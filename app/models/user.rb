class User < ApplicationRecord
  attr_accessor :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :user_like_books, dependent: :destroy
  has_many :books, through: :user_like_books
  has_many :follows, dependent: :destroy
  has_many :followed_publishers, through: :follows, source: :followable,
            source_type: "publisher"
  has_many :followed_authors, through: :follows, source: :followable,
            source_type: "author"

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
  scope :filtered_by_name, lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  }

  has_secure_password

  # Activates an account.
  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  # Inactivates an account.
  def inactivate
    update_columns activated: false, activated_at: Time.zone.now
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  class << self
    # Returns the hash digest of the given string.
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def has_reviewed? book_id
    reviews.exists?(book_id:)
  end

  # Returns true if the given token matches the digest.
  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end
  private

  def downcase_email
    email.downcase!
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
