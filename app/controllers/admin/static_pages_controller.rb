class Admin::StaticPagesController < Admin::BaseController
  def index
    @user_count = User.count
    @book_count = Book.count
    @author_count = Author.count
    @publisher_count = Publisher.count
    @category_count = Category.count
    @transaction_count = Transaction.count
  end
end
