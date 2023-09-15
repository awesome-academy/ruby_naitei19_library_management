class Publisher < ApplicationRecord
  has_many :books, dependent: :nullify
  has_many :follows, as: :followable, dependent: :destroy
  has_many :followers, through: :follows, source: :user
  validates :name, presence: true, length: {maximum: Settings.category.max}
  validates :address, presence: true
  validates :email, presence: true, uniqueness: true,
            length: {maximum: Settings.validate.email.length.max},
            format: {with: Settings.validate.email.regex}
  scope :filtered_by_name, lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  }
  scope :search_all, lambda {|query|
    joins(:books).where(
      "books.title LIKE :q OR publishers.email LIKE :q
        OR publishers.address LIKE :q
        OR publishers.name LIKE :q
        ",
      q: "%#{query}%"
    )
  }
end
