class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe,
                                  :post_idea, :delete_idea, :kick_user, :unlock_tour, :lock_tour]

  before_action :authenticate_user!, except: :index

  # GET /tours
  def index
    @tours = Tour.includes(:owner, :users, :languages).order("created_at DESC")

    if params[:category].blank?
      @tours = @tours.all
    else
      @category_id = Category.find_by(name: params[:category]).id
      @tours = @tours.where(:category_id => @category_id)
    end
  end

# GET /tours_by_owner
  def tours_by_owner
    @tours = Tour.includes(:owner,  :users, :languages).where(owner: current_user ).order("created_at DESC").all
   @tourstrip = Tour.includes(:tours_users).where(:tours_users => { :kicked => false,user_id: current_user, :active_subscription => true}).all
    # @tourstrip = Tour.all
  end

  # GET /tours/1
  def show
 # for superuser
  @members = @tour.tours_users.includes(:user).where(kicked: false , active_subscription:true)
#   if current_user.is_superuser == true
#     subscription = current_user.tours_users.where(tour: @tour).first_or_initialize
#     subscription.active_subscription = true
#     subscription.save!
# # for superuser to see all member chat and idea
#     @ideas = @tour.ideas
#     @idea = Idea.new
#     @messages = @tour.messages.includes(:user)
#     @message = Message.new
#     @allowed_user =  current_user == @tour.owner || @tour.tours_users.active.where(user: current_user, kicked: false).first.present?
#   else
    @ideas = @tour.ideas
    @idea = Idea.new
    @messages = @tour.messages.includes(:user)
    @message = Message.new

    @allowed_user =  current_user == @tour.owner || current_user.is_superuser == true || @tour.tours_users.active.where(user: current_user, kicked: false).first.present?
  # end
  end

  # GET /tours/new
  def new
    @tour = Tour.new
    @tour.tour_languages.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
    #@languages= Language.all

  end

  # GET /tours/1/edit
  def edit
    @tour.owner == current_user || not_found
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  # POST /tours
  def create
    @tour = Tour.new(tour_params)
    @tour.owner = current_user

    if @tour.save
      redirect_to @tour, notice: 'Tour was successfully created.'
    else
      @categories = Category.all.map{ |c| [c.name, c.id] }
      render :new
    end
  end

  # PATCH/PUT /tours/1
  def update
    @tour.owner == current_user || not_found
    if @tour.update(tour_params)
      redirect_to @tour, notice: 'Tour was successfully updated.'
    else
      @categories = Category.all.map{ |c| [c.name, c.id] }
      render :edit
    end
  end

  # DELETE /tours/1
  def destroy
    @tour.owner == current_user || not_found
    @tour.destroy
    redirect_to tours_url, notice: 'Tour was successfully destroyed.'
  end

  def subscribe
    if @tour.locked?
      redirect_to tour_path(@tour), :flash => { notice: 'This group is locked by the organiser.' }
    elsif current_user.tours_users.active.where(tour: @tour, kicked: false).any?
      redirect_to tour_path(@tour), :flash => { notice: 'You are already subscribed.' }
    elsif current_user.tours_users.active.where(tour: @tour, kicked: true).any?
      redirect_to tour_path(@tour), :flash => { alert: 'The trip owner has limited your access to this page.' }
    else
      subscription = current_user.tours_users.where(tour: @tour).first_or_initialize
      subscription.active_subscription = true
      subscription.save!
      redirect_to tour_path(@tour), :flash => { notice: 'You are subscribed successfully.' }
    end
  end

  def unsubscribe
    @tour = Tour.find(params[:id])
    if @tour.owner==current_user
      user = @tour.tours_users.first.user
      @tour.update(owner: user)
      @tour.tours_users.first.destroy
    end

    subscription = current_user.tours_users.active.where(tour: @tour).first
    if subscription.present?
      subscription.update_attribute(:active_subscription, false)
      redirect_to root_path(@tour), :flash => { notice: 'You are unsubscribed.' }
    else
      redirect_to tour_path(@tour), :flash => { alert: 'You don`t have active subscription to this trip.' }
    end
  end

 def trip_leave
    @tour = Tour.find(params[:id])
    @tour.destroy
    redirect_to root_path, :flash => { notice: 'Your trip is no longer available.' }
 end

  def post_idea
    @tour.owner == current_user || current_user.is_superuser == true || not_found

    text = params.dig(:idea,:text)
    if  text.present? && @tour.ideas.create(text: text)
      redirect_to tour_path(@tour), :flash => { notice: 'An idea is saved.' }
    else
      redirect_to tour_path(@tour), :flash => { alert: 'Input correct idea text.' }
    end
  end

  def delete_idea
    @tour.owner == current_user || not_found

    idea = @tour.ideas.where(id: params[:idea_id]).first

    if idea.present?
      idea.delete
      redirect_to tour_path(@tour), :flash => { notice: 'The idea is deleted.' }
    else
      redirect_to tour_path(@tour), :flash => { alert: 'The idea is not found.' }
    end
  end

  def kick_user
    @tour.owner == current_user || not_found
    subscription = ToursUser.where(tour: @tour, user_id: params[:user_id]).first
    if subscription.present?
      subscription.update_attribute(:kicked, true)
      redirect_to tour_path(@tour), :flash => { notice: 'User is kicked out of this trip.' }
    else
      redirect_to tour_path(@tour), :flash => { alert: 'The user subscription is not found.' }
    end
  end

  def unlock_tour
    @tour.owner == current_user || not_found
    if @tour.update_attribute(:locked, false)
      redirect_to tour_path(@tour), :flash => { notice: 'The tour is unlocked.' }
    else
      redirect_to tour_path(@tour), :flash => { alert: 'A problem has occurred. Try again later.' }
    end
  end

  def lock_tour
    @tour.owner == current_user || not_found
    if @tour.update_attribute(:locked, true)
      redirect_to tour_path(@tour), :flash => { notice: 'The tour is locked.' }
    else
      redirect_to tour_path(@tour), :flash => { alert: 'A problem has occurred. Try again later.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:full_name, :email,:phone_number,:message)
    end
    # Only allow a trusted parameter "white list" through.
    def tour_params
      params.require(:tour).permit(:name, :description, :start_time, :category_id,
                                   :tour_img, :language_id, :from_point, :to_point,
                                   tour_languages_attributes: [:id, :language_id, :_destroy])
    end
end
