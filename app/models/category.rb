class Category < ApplicationRecord
  has_many :books_categories, dependent: :destroy
  has_many :books, through: :books_categories
end
