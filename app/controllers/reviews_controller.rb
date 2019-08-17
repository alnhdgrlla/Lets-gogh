class ReviewsController < ApplicationController
  before_action :set_user
  before_action :set_supply

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = @user
    @review.supply = @supply
    if @review.save
      redirect_to @supply
    else
      render :new
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_supply
    @supply = Supply.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
