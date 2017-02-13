class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :edit, :update, :destroy]

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
