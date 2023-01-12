class Admin::ReviewsController < ApplicationController

  def index
    company = Company.find(params[:company_id])
    @reviews = Review.where(company_id: company.id)
  end

  def show
    @company = Company.find(params[:company_id])
    @review = Review.find(params[:id])
    @review_comments = ReviewComment.where(review_id: @review.id)
    @review_comment = ReviewComment.new
  end

  def update
    @company = Company.find(params[:company_id])
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to admin_company_review_path(@company.id, @review.id)
  end

  def review_params
    params.require(:review).permit(:driver_id, :company_id, :objective, :method, :baggage, :vehicle, :reception_time, :order, :waiting_place, :other, :deletion)
  end

end
