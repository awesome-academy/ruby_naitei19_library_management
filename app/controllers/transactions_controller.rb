class TransactionsController < ApplicationController
  before_action :logged_in_user
  before_action :find_book, only: %i(new create)
  before_action :find_user, only: %i(index destroy)
  # before_action :find_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = @user.transactions
                         .filter_by_status(params[:transaction_status])
                         .order(updated_at: :desc)
                         .paginate(
                           page: params[:page],
                           per_page: Settings.authors.per_page
                         )
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = @book.transactions.build(transaction_params)
    if books_number_valid?
      @transaction.save ? handle_when_created_success : handle_when_created_fail
    else
      handle_when_created_fail
    end
  end

  def destroy; end

  private

  def find_book
    @book = Book.find_by(id: params[:book_id])
    return if @book

    flash[:danger] = t("book.wrong")
    redirect_to root_path
  end

  def find_user
    @user = User.find_by(id: params[:user_id])
    return if @user

    flash[:danger] = t("book.wrong")
    redirect_to root_path
  end

  def handle_when_created_success
    flash[:success] = t("transactions.create.success")
    redirect_to book_path(@book)
  end

  def handle_when_created_fail
    flash.now[:danger] = t("transactions.create.fail")
    render :new, status: :unprocessable_entity
  end

  def books_number_valid?
    (@book.book_amount.to_i - @transaction.amount.to_i).positive?
  end

  def find_transaction
    @transaction = @book.transactions.find_by(id: params[:id])
    return if @transaction

    flash[:danger] = t("book.wrong")
    redirect_to root_path
  end

  def transaction_params
    params.require(:transaction).permit(:borrow_date, :expire_date, :amount,
                                        :user_id)
  end
end
