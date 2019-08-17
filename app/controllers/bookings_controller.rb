class BookingsController < ApplicationController
  before_action :set_supply, only: [:new, :create]
  before_action :set_booking, only: [:show, :update]

  def index
    @bookings = policy_scope(Booking)
    @bookings = @bookings.where(user: current_user)
  end

  def show
    authorize_booking
    @supply = @booking.supply
  end

  def new
    @booking = Booking.new
    authorize_booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize_booking
    @booking.user = current_user
    @booking.supply = @supply
    if @booking.save
      redirect_to bookings_path
    else
      puts @booking.errors.messages
      render "supplies/show"
    end
  end

  def update
    authorize_booking
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      @supply = @booking.supply
      render :show
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
