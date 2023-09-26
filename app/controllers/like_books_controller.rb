class LikeBooksController < ApplicationController
  before_action :logged_in_user
  before_action :load_book
  before_action :load_liked, only: :destroy
  def index
    @books = current_user.books.search_all(params[:search] || "")
                         .distinct.paginate(page: params[:page],
                                            per_page: Settings.page.limit_items)
  end

  def new
    @liked = UserLikeBook.new
  end

  def create
    @liked = current_user.user_like_books.new
    @liked.book_id = @book.id

    respond_to do |format|
      if @liked.save
        format.html{redirect_to @book}
        format.turbo_stream
      else
        flash[:danger] = t("like.like_fail")
      end
    end
  end

  def destroy
    respond_to do |format|
      if @liked.destroy
        format.html{redirect_to @book, status: :see_other}
        format.turbo_stream
      else
        flash[:danger] = t("like.unlike_fail")
      end
    end
  end

  private

  def load_book
    @book = Book.find_by id: params[:book_id]
  end

  def load_liked
    @liked = current_user.user_like_books.find_by book_id: params[:book_id]
  end
end
