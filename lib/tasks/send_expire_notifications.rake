desc "Send notifications for expired transactions"
task send_expire_notifications: :environment do
  transactions_to_notify = Transaction.success.where(
    "DATEDIFF(expire_date,CURRENT_TIMESTAMP()) = ? ", 1
  )

  transactions_to_notify.each do |transaction|
    TransactionMailer.notify_expire(transaction.user, transaction).deliver_now
  end
end
