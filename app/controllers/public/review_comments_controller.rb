class Public::ReviewCommentsController < ApplicationController
  before_action :authenticate_any!

  def create
    @review = Review.find(params[:review_id])
    @review_comment = current_driver.review_comments.new(review_comment_params)
    @review_comment.review_id = @review.id
    @review_comment.save
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:driver_id, :review_id, :comment, :deletion)
  end

  def authenticate_any!
    if driver_signed_in?
        true
    else
        authenticate_transport_company!
    end
  end

end
