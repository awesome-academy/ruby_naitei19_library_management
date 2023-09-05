class Transaction < ApplicationRecord
  enum status: {pending: 0, success: 1, fail: 2, expire: 3}
  belongs_to :user
  belongs_to :book
end
