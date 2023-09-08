class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :rating, presence: true
  validates :comment, presence: true
  delegate :name, to: :user, prefix: true, allow_nil: true
end
