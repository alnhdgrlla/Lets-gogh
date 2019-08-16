class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if !params[:search].nil? && params[:search][:query].present?
      @supplies = policy_scope(Supply).search_by_category_title_desc(params[:search][:query])
    elsif params[:tag].present?
      @supplies = policy_scope(Supply).tagged_with(params[:tag])
    else
      @supplies = policy_scope(Supply)
    end
  end
end
