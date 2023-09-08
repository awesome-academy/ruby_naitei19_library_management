class Admin::BooksController < Admin::BaseController
  def index
    @books = Book.all
  end

  def new; end

  def edit; end

  def destroy; end
end
