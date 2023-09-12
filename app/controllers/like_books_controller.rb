class LikeBooksController < ApplicationController
  def index
    @books = current_user.books.search_all(params[:search] || "")
                         .distinct.paginate(page: params[:page],
                                            per_page: Settings.page.limit_items)
  end
end
