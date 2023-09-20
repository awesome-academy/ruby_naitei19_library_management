class Admin::StaticPagesController < Admin::BaseController
  before_action :data_count, :borrow_category, only: :index
  def index
    @category_books = Category
                      .joins(:books_categories)
                      .select("categories.category_name,
                              COUNT(book_id) AS book_count")
                      .group("categories.category_name")
                      .paginate(page: params[:page],
                                per_page: Settings.authors.per_page)
  end

  private

  def data_count
    @user_count = User.count
    @book_count = Book.count
    @author_count = Author.count
    @publisher_count = Publisher.count
    @category_count = Category.count
    @pending_transaction_count = Transaction.pending.count
  end

  def borrow_category
    current_date = Time.zone.today
    start_of_year = current_date.beginning_of_year

    @most_borrowed_month = Category
                           .joins(books: :transactions)
                           .where(transactions:
                                  {borrow_date: current_date.all_month})
                           .group("categories.id")
                           .order("COUNT(transactions.id) DESC")
                           .limit(1)
                           .first

    @most_borrowed_year = Category
                          .joins(books: :transactions)
                          .where(transactions:
                                {borrow_date: start_of_year..current_date})
                          .group("categories.id")
                          .order("COUNT(transactions.id) DESC")
                          .limit(1)
                          .first
  end
end
