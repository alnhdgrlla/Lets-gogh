class SuppliesController < ApplicationController
  before_action :set_supply, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @supplies = policy_scope(Supply)
  end

  def show
    authorize_supply
  end

  def new
    authorize_supply
    @supply = Supply.new
  end

  def create
    authorize_supply
    @supply = Supply.new(supply_params)
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
      redirect_to flat_path(@supply)
    else
      render :edit
    end
  end

  private

  def set_supply
    @supply = Supply.find(params[:id])
  end

  def supply_params
    params.require(:supply).permit(:title, :price, :category, :description, :user_id)
  end

  def authorize_supply
    authorize @supply
  end
end






