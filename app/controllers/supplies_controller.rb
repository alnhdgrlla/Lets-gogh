class SuppliesController < ApplicationController
  before_action :set_supply, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show, :tagged]
  skip_after_action :verify_authorized, only: :my_supplies

  def index
    if params[:search][:query].present?
      @supplies = policy_scope(Supply).search_by_category_title_desc(params[:search][:query])
    else
      @supplies = policy_scope(Supply)
    end
  end

  def show
    @supply = Supply.find(params[:id])
    @review = Review.new
    @supply.geocode
    authorize_supply
    @markers = []

    marker =
    {
      lat: @supply.latitude,
      lng: @supply.longitude
    }

    @markers << marker

    @booking = Booking.new
  end

  def new
    @supply = Supply.new
    authorize_supply
  end

  def create
    @supply = Supply.new(supply_params)
    authorize_supply
    @supply.user = current_user
    # raise
    if @supply.save
      redirect_to supply_path(@supply)
    else
      render :new
    end
  end

  def edit
    authorize_supply
  end

  def update
    authorize_supply
    if @supply.update(supply_params)
      redirect_to supply_path(@supply)
    else
      render :edit
    end
  end

  def destroy
    authorize_supply
    @supply.destroy
    redirect_to root_path
  end

  def my_supplies
    @supplies = current_user.supplies
  end

  def tagged
    if params[:tag].present?
      @supplies = Supply.tagged_with(params[:tag])
    else
      @supplies = policy_scope(Supply)
    end
  end

  private

  def set_supply
    @supply = Supply.find(params[:id])
  end

  def supply_params
    params.require(:supply).permit(:title, :price, :category, :description, :user_id, :photo, :tag_list, :location)
  end

  def authorize_supply
    authorize @supply
  end
end
