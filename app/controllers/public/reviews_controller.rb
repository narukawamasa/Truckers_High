class Public::ReviewsController < ApplicationController

  def new
    @company = Company.find(params[:company_id])
    @review = Review.new
  end

  def create
    @company = Company.find(params[:company_id])
    @review = current_driver.reviews.new(review_params)
    #@review.company_id = @company.id
    @review.save
    redirect_to company_reviews_path
  end

  def show
  end

  def index
    company = Company.find(params[:company_id])
    @reviews = Review.where(company_id: company.id)
  end

  def edit
  end

  def update
  end

  def review_params
    params.require(:review).permit(:driver_id, :company_id, :objective, :method, :baggage, :vehicle, :reception_time, :order, :waiting_place, :other, :deletion)
  end


end
