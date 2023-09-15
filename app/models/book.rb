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
  accepts_nested_attributes_for :books_authors, allow_destroy: true
  accepts_nested_attributes_for :books_categories, allow_destroy: true
  accepts_nested_attributes_for :images
  validates :title, presence: true, length: {maximum: Settings.book.title_max}
  validates :published_year, numericality: {only_integer: true,
                                            greater_than_or_equal_to:
                                            Settings.book.year}
  validates :book_amount, numericality: {only_integer: true,
                                         greater_than_or_equal_to:
                                         Settings.book.amount}
  validates :publisher_id, presence: true
  validates :average_rating, numericality: {greater_than_or_equal_to:
                                            Settings.book.rate_min,
                                            less_than_or_equal_to:
                                            Settings.book.rate_max}
  validates :author_ids, presence: {message: I18n.t("admin.book.select")}
  validates :category_ids, presence: {message: I18n.t("admin.book.select")}
  scope :search_all, lambda {|query|
    joins(:publisher, :authors, :categories).where(
      "books.title LIKE :q OR books.description LIKE :q
        OR publishers.name LIKE :q OR authors.name LIKE :q
        OR categories.category_name LIKE :q
        ",
      q: "%#{query}%"
    )
  }
  scope :filtered_by_name, lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  }

  before_create :set_default_average_rating

  private

  def set_default_average_rating
    self.average_rating ||= 0
  end
end
