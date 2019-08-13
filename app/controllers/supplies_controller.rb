class SuppliesController < ApplicationController
  before_action :set_supply, only: [:show, :edit, :update]
  
  def index
    @supplies = Supply.all
  end

  def show
  end

  def new
    @supply = Supply.new
  end

  def create
    @supply = Supply.new(supply_params)
    if @supply.save
      redirect_to supply_path(@supply)
    else
      render :new
    end
  end

  def edit
  end

  def update
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
end
