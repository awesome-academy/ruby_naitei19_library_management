class BooksController < ApplicationController
  before_action :find_book, only: %i(show)
  def index
    @books = Book.search_all(params[:search] || "")
                 .distinct.paginate(page: params[:page],
                                    per_page: Settings.page.limit_items)
  end

  def show; end

  private
  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t("book.wrong")
    redirect_to root_path
  end
end
