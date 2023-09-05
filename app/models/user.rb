class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :user_like_books, dependent: :destroy
  has_many :books, through: :user_like_books

  enum gender: {male: 0, female: 1}
  enum role: {normal_user: 0, admin: 1}
end
