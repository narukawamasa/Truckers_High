class Admin::ReviewCommentsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.update(review_comment_params)
    redirect_to request.referer
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:driver_id, :review_id, :comment, :deletion)
  end

end
