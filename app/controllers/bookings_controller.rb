class BookingsController < ApplicationController
  before_action :set_supply, only: [:show]

  def index
    @bookings = policy_scope(Booking)
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
    if @booking.create
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit!
  end

  def authorize_booking
    authorize @booking
  end
end
