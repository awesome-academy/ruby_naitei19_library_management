class Author < ApplicationRecord
  has_many :books_authors, dependent: :destroy
  has_many :books, through: :books_authors
  has_many :follows, as: :followable, dependent: :destroy
  has_many :followers, through: :follows, source: :user
  has_one_attached :avatar
  validates :name, presence: true, length: {maximum: Settings.category.max}
  validates :country, presence: true, length: {maximum: Settings.category.max}
  validates :date_of_birth, presence: true
  validates :avatar, content_type: {in: Settings.model.image_type,
                                    message: I18n.t("image.mess1")},
                     size: {less_than: 5.megabytes,
                            message: I18n.t("image.mess2")}

  scope :filtered_by_name, lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  }
end
