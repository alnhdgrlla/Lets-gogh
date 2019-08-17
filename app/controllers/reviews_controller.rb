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
    authorize @review
    if @review.save
      respond_to do |format|
        format.html { redirect_to @supply }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_supply
    @supply = Supply.find(params[:supply_id])
  end

  def review_params
    params.require(:review).permit(:content)
  end
end
