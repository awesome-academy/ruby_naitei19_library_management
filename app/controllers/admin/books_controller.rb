class Admin::BooksController < Admin::BaseController
  before_action :find_book, except: %i(index new create export_excel)
  before_action :set_books, only: [:index]
  def index
    @books = @books.paginate(page: params[:page],
                             per_page: Settings.page.limit_items)
  end

  def export_excel
    search = session[:search] || ""
    @books = Book.search_all(search).distinct
    respond_to do |format|
      format.xlsx do
        response.headers["Content-Disposition"] =
          %(attachment; filename="books_#{search}.xlsx")
      end
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      # create_book_associations
      flash[:success] = t("admin.book.create_success")
      redirect_to admin_book_path(@book)
    else
      flash[:warning] = t("admin.book.create_fail")
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @book = Book.new
  end

  def update
    if @book.update(book_params)
      flash[:success] = t("admin.book.update_success")
      redirect_to admin_book_path(@book)
    else
      render :edit, status: :unprocessable_entity
      flash[:warning] = t("admin.book.update_fail")
    end
  end

  def show; end

  def edit; end

  def destroy
    if @book.destroy
      flash[:success] = t("admin.book.destroy_success")
    else
      flash[:warning] = t("admin.book.destroy_fail")
    end
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :published_year,
                                 :book_amount, :publisher_id, category_ids: [],
                                 author_ids: [],
                                 images_attributes: [:id, :image])
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t("admin.book.not_found")
    redirect_to admin_books_path
  end

  def set_books
    @books = Book.search_all(params[:search] || "").distinct
    session[:search] = params[:search]
  end
end
