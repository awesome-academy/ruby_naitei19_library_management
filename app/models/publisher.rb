class Publisher < ApplicationRecord
  has_many :books, dependent: :nullify
  validates :name, presence: true, length: {maximum: Settings.category.max}
  validates :address, presence: true
  validates :email, presence: true, uniqueness: true,
            length: {maximum: Settings.validate.email.length.max},
            format: {with: Settings.validate.email.regex}
  scope :filtered_by_name, lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  }
end
