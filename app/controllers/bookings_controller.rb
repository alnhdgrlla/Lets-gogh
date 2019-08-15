class BookingsController < ApplicationController
  before_action :set_supply, only: [:show, :new, :create]

  def index
    @bookings = policy_scope(Booking)
    @bookings = @bookings.where(user: current_user)
  end

  def show
    authorize_booking
  end

  def new
    @booking = Booking.new
    authorize_booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize_booking
    @booking.user = current_user
    if @booking.save
      redirect_to supply_booking_path(@booking)
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_supply
    @supply = Supply.find(params[:supply_id])
  end

  def booking_params
    params.require(:booking).permit!
  end

  def authorize_booking
    authorize @booking
  end
end
