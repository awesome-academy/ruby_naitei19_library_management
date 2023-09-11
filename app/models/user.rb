class User < ApplicationRecord
  before_save :downcase_email

  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :user_like_books, dependent: :destroy
  has_many :books, through: :user_like_books

  enum gender: {male: 0, female: 1}
  enum role: {normal_user: 0, admin: 1}

  validates :name, presence: true, length: {maximum: Settings.degit.length_name}
  validates :email, presence: true,
                    length: {maximum: Settings.degit.length_email},
                    format: {with: Settings.regex.email},
                    uniqueness: true
  validates :password, presence: true,
                       length: {minimum: Settings.degit.length_6},
                       allow_nil: true

  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost
  end

  private

  def downcase_email
    email.downcase!
  end
end
