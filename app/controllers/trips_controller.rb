class TripsController < ApplicationController
before_action :find_trip, only: [:show, :edit, :update, :destroy]
	def index
		if params[:category].blank?
			@trips = Trip.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@trips = Trip.where(:category_id => @category_id).order("created_at DESC")
		end
	end

	def show
	end

	def new
		@trip = current_user.trips.build
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	def create
		@trip = current_user.trips.build(trip_params)
		@trip.category_id = params[:category_id]

			if @trip.save
				redirect_to root_path
			else
				render 'new'
			end
	end

	def edit
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	def update
		@trip.category_id = params[:category_id]
		if @trip.update(trip_params)
			redirect_to trip_path(@trip)
		else
			render 'edit'
		end
	end

	def destroy
		@trip.destroy
		redirect_to root_path
	end


	private

		def trip_params
			params.require(:trip).permit(:title, :description, :language, :start, :category_id)
		end

		def find_trip
			@trip = Trip.find(params[:id])
		end

end
