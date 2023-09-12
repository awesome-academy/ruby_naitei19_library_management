class Category < ApplicationRecord
  has_many :books_categories, dependent: :destroy
  has_many :books, through: :books_categories
  validates :category_name, presence: true, uniqueness: true,
                            length: {maximum: Settings.category.max}

  scope :filtered_by_name, lambda {|name|
    where("category_name LIKE ?", "%#{name}%") if name.present?
  }
end
