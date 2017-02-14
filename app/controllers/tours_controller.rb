class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe, :post_idea, :delete_idea]

  # GET /tours
  def index
    if params[:category].blank?
      @tours = Tour.includes(:owner).all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @tours = Tour.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  # GET /tours/1
  def show
    @ideas = @tour.ideas
    @idea = Idea.new
    @messages = @tour.messages.includes(:user)
    @message = Message.new
  end

  # GET /tours/new
  def new
    @tour = Tour.new
    @categories = Category.all.map{ |c| [c.name, c.id] }
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
    if current_user.tours_users.acive.where(tour: @tour, kicked: false).any?
      redirect_to tour_path(@tour), :flash => { notice: 'You are already subscribed.' }
    elsif current_user.tours_users.acive.where(tour: @tour, kicked: true).any?
      redirect_to tour_path(@tour), :flash => { alert: 'The trip owner has limited your access to this page.' }
    else
      current_user.tours_users.create(tour: @tour)
      redirect_to tour_path(@tour), :flash => { notice: 'You are subscribed successfully.' }
    end
  end

  def unsubscribe
    subscription = current_user.tours_users.acive.where(tour: @tour).first
    if subscription.present?
      subscription.update_attribute(:active_subscription, false)
      redirect_to tour_path(@tour), :flash => { notice: 'You are unsubscribed.' }
    else
      redirect_to tour_path(@tour), :flash => { alert: 'You don`t have active subscription to this trip.' }
    end
  end

  def post_idea
    @tour.owner == current_user || not_found

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tour_params
      params.require(:tour).permit(:name, :description, :start_time, :category_id)
    end
end
