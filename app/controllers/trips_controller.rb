class TripsController < ApplicationController
  before_action :set_trip, only:  %i[show edit update destroy]

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    authorize @trip
    if @trip.save
      redirect_to user_trips_path, notice: "Trip was succefully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def  index
    @trips = Trip.all
    @restaurants = policy_scope(Restaurant)
  end

  def show
    authorize @trip
  end

  def edit
    authorize @trip
  end

  def update
    authorize @trip
    if @trip.update(trip_params)
      redirect_to user_trips_path, notice: "Trip was succefully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @trip
    @trip.destroy
    redirect_to user_trips_path, notice: "Trip was succefully destroyed.", status: :see_other
  end

  private

  def trip_params
    params.require(:trip).permit(:destination, :star_date, :end_date)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
