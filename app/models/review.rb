class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  delegate :name, to: :user, prefix: true, allow_nil: true
end
