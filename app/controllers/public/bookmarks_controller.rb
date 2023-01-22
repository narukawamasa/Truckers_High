class Public::BookmarksController < ApplicationController

  def index
    @bookmarks = current_driver.bookmarks.all
  end

  def create
    bookmark = Bookmark.new(bookmark_params)
    bookmark.save
    @bookmark = Bookmark.new
    @company = Company.find(params[:bookmark][:company_id])
    #redirect_to bookmarks_path
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    @bookmark = Bookmark.new
    @company = Company.find(params[:company_id])

    #redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:driver_id, :company_id)
  end


end
