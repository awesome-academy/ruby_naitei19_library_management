class StaticPagesController < ApplicationController
  def index
    @books = Book.paginate(page: params[:page],
                           per_page: Settings.page.limit_items)
  end
end
