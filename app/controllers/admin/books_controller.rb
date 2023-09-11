class Admin::BooksController < Admin::BaseController
  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      create_book_authors
      create_books_categories
      flash[:success] = t("admin.book.create_success")
      redirect_to @book
    else
      render :new
    end
  end

  def new
    @book = Book.new
  end

  def edit; end

  def destroy; end

  private

  def create_book_authors
    params[:book][:author_ids].each do |author_id|
      author = Author.find_by(id: author_id)
      if author.present?
        book_author = BooksAuthor.new(book_id: @book.id, author_id: author.id)
        book_author.save
      end
    end
  end

  def create_books_categories
    params[:book][:category_ids].each do |category_id|
      category = Category.find_by(id: category_id)
      if category.present?
        b_c = BooksCategory.new(book_id: @book.id, category_id: category.id)
        b_c.save
      end
    end
  end

  def book_params
    params.require(:book).permit(:title, :description, :published_year,
                                 :book_amount, :publisher_id, :average_rating,
                                 images_attributes: [:id, :image, :_destroy])
  end
end
