class StaticPagesController < ApplicationController
  def index
    if logged_in?
      @followed_books = get_followed_books
      @books = search_followed_books(@followed_books)
    else
      @books = Book.search_all(params[:search] || "")
                   .distinct.paginate(page: params[:page],
                                      per_page: Settings.page.limit_items)
    end
  end

  private

  def get_followed_books
    @followed_publishers = current_user.followed_publishers
    @followed_authors = current_user.followed_authors

    followed_publishers_books = @followed_publishers.map(&:books).flatten
    followed_authors_books = @followed_authors.map(&:books).flatten
    followed_publishers_books + followed_authors_books
  end

  def search_followed_books followed_books
    Book.search_all(params[:search] || "")
        .where(id: followed_books.pluck(:id))
        .distinct.paginate(page: params[:page],
                           per_page: Settings.page.limit_items)
  end
end
