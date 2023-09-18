class Admin::TransactionsController < Admin::BaseController
  before_action :find_transaction, only: %i(update)

  def index
    @transactions = Transaction.order(updated_at: :desc)
                               .filter_by_status(params[:transaction_status])
                               .paginate(
                                 page: params[:page],
                                 per_page: Settings.authors.per_page
                               )
  end

  def update
    # Avoid callback trigger
    if @transaction.update_column(:status, transaction_params[:status])
      handle_when_update_success
    else
      handle_when_update_fail
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:status)
  end

  def find_transaction
    @transaction = Transaction.find_by(id: params[:id])
    return if @transaction

    flash[:danger] = t("book.wrong")
    redirect_to admin_transactions_path
  end

  def handle_when_update_success
    if @transaction.fail?
      new_book_amount = @transaction.amount.to_i + @transaction.book.book_amount
      @transaction.book.update_column(:book_amount, new_book_amount)
    end
    flash[:success] =
      if @transaction.success?
        t("admin.transaction.actions.accepted")
      else
        t("admin.transaction.actions.denied")
      end
    redirect_to admin_transactions_path
  end

  def handle_when_update_fail
    flash.now[:danger] = t("book.wrong")
    redirect_to admin_transactions_path
  end
end
