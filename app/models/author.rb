class Author < ApplicationRecord
  has_many :books_authors, dependent: :destroy
  has_many :books, through: :books_authors

  scope :filtered_by_name, lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  }
end
