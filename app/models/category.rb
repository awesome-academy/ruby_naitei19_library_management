class Category < ApplicationRecord
  has_many :books_categories, dependent: :destroy
  has_many :books, through: :books_categories
  scope :filtered_by_name, lambda {|name|
    where("category_name LIKE ?", "%#{name}%") if name.present?
  }
end
