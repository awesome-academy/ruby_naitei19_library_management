class StaticPagesController < ApplicationController
  def index
    @books = Book.search_all(params[:search] || "")
                 .distinct.paginate(page: params[:page],
                                    per_page: Settings.page.limit_items)
  end
end
