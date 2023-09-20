# lib/tasks/expire_date_checker.rake
namespace :expire_date_checker do
  desc "Start the Expire Date Checker"
  task start: :environment do
    checker = ExpireDateChecker.new
    checker.start
    puts "Expire Date Checker started. Press Ctrl+C to stop."
    trap("INT"){checker.stop}
    sleep
  end
end
