class Book < ApplicationRecord
  belongs_to :publisher
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :books_categories, dependent: :destroy
  has_many :categories, through: :books_categories
  has_many :transactions, dependent: :destroy
  has_many :books_authors, dependent: :destroy
  has_many :authors, through: :books_authors
  has_many :user_like_books, dependent: :destroy
  has_many :users, through: :user_like_books
  delegate :name, to: :publisher, prefix: true, allow_nil: true
  accepts_nested_attributes_for :images, allow_destroy: true
end
