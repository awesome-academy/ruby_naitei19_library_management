# lib/expire_date_checker.rb
class ExpireDateChecker
  def initialize
    @running = true
  end

  def start
    Thread.new do
      while @running
        check_and_update_expire_dates
        sleep(1) # Sleep for 1 second (adjust as needed)
      end
    end
  end

  def stop
    @running = false
  end

  private

  def check_and_update_expire_dates
    today = Time.zone.today
    transactions = Transaction.where(status: :success).where(
      "DATE(expire_date) <= ?", today
    )
    transactions.update_all(status: "expire")
  end
end
