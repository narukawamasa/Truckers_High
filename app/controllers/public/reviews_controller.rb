class Public::ReviewsController < ApplicationController
  before_action :authenticate_any!
  before_action :is_matching_login, only: [:edit]

  def new
    @company = Company.find(params[:company_id])
    @review = Review.new
  end

  def create
    @company = Company.find(params[:company_id])
    @review = current_driver.reviews.new(review_params)
    @review.company_id = @company.id
    if @review.save
      redirect_to company_reviews_path
    else
      render :new
    end
  end

  def show
    @company = Company.find_by(id: params[:company_id])
    if @company.nil?
      redirect_to root_path
    end
    @review = Review.find_by(id: params[:id])
    if @review.nil?
      redirect_to root_path
    end
    @review_comments = ReviewComment.where(review_id: @review.id)
    @review_comment = ReviewComment.new
  end

  def index
    company = Company.find_by(id: params[:company_id])
    if company.nil?
      redirect_to root_path
    end
    search = params[:search]
    if params[:search] == nil || params[:search] == ""
      @reviews = Review.where(company_id: company.id).page(params[:page])
    else
      #卸しか積みかその他で検索をかけるため
      if search == "0"
        @reviews = Review.where(company_id: company.id, objective: 0).page(params[:page])
      elsif search == "1"
        @reviews = Review.where(company_id: company.id, objective: 1).page(params[:page])
      elsif search == "2"
        @reviews = Review.where(company_id: company.id, objective: 2).page(params[:page])
      else
        @reviews = Review.where(company_id: company.id).page(params[:page])
      end
    end
  end

  def edit
    @review = Review.find(params[:id])
    @company = Company.find(params[:company_id])
  end

  def update
    @company = Company.find(params[:company_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to company_review_path(@company.id, @review.id)
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:driver_id, :company_id, :objective, :method, :baggage, :vehicle, :reception_time, :order, :waiting_place, :other, :deletion)
  end

  def authenticate_any!
    if driver_signed_in?
        true
    else
        authenticate_transport_company!
    end
  end

  def is_matching_login
    if driver_signed_in?
      review_id = params[:id].to_i
      unless current_driver.reviews.find_by(id: review_id)
        redirect_to driver_path(current_driver)
      end
    elsif transport_company_signed_in?
        redirect_to transport_company_path(current_transport_company)
    end
  end


end
