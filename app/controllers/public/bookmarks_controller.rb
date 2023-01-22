class Public::BookmarksController < ApplicationController

  def index
    @bookmarks = current_driver.bookmarks.all
  end

  def create
    bookmark = Bookmark.new(bookmark_params)
    bookmark.save
    @bookmark = Bookmark.new
    if params[:word] == nil || params[:word] == ""
      @companies = Company.all
    else
      word = params[:word]
      search = params[:search]
      if search == "perfect_match"
        @companies = Company.where("name LIKE?", "#{word}")
        @word = word
      elsif search == "forward_match"
        @companies = Company.where("name LIKE?","#{word}%")
        @word = word
      elsif search == "backward_match"
        @companies = Company.where("name LIKE?","%#{word}")
        @word = word
      elsif search == "partial_match"
        @companies = Company.where("name LIKE?","%#{word}%")
        @word = word
      else
        @companies = Company.all
      end

      unless @companies.exists?
        @companies = Company.all
        @word_error = word
      end

    end
    #redirect_to bookmarks_path
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    @bookmark = Bookmark.new
    if params[:word] == nil || params[:word] == ""
      @companies = Company.all
    else
      word = params[:word]
      search = params[:search]
      if search == "perfect_match"
        @companies = Company.where("name LIKE?", "#{word}")
        @word = word
      elsif search == "forward_match"
        @companies = Company.where("name LIKE?","#{word}%")
        @word = word
      elsif search == "backward_match"
        @companies = Company.where("name LIKE?","%#{word}")
        @word = word
      elsif search == "partial_match"
        @companies = Company.where("name LIKE?","%#{word}%")
        @word = word
      else
        @companies = Company.all
      end

      unless @companies.exists?
        @companies = Company.all
        @word_error = word
      end

    end
    #redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:driver_id, :company_id)
  end


end
