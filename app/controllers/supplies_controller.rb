class SuppliesController < ApplicationController
  before_action :set_supply, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @supplies = policy_scope(Supply)
  end

  def show
    authorize_supply
  end

  def new
    @supply = Supply.new
    authorize_supply
  end

  def create
    @supply = Supply.new(supply_params)
    authorize_supply
    @supply.user = current_user
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

  private

  def set_supply
    @supply = Supply.find(params[:id])
  end

  def supply_params
    params.require(:supply).permit(:title, :price, :category, :description, :user_id, :photo)
  end

  def authorize_supply
    authorize @supply
  end
end
