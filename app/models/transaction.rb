class Transaction < ApplicationRecord
  enum status: {pending: 0, success: 1, fail: 2, expire: 3}
  belongs_to :user
  belongs_to :book

  validates :borrow_date, :expire_date, presence: true
  validates :amount, presence: true,
            numericality: {greater_than: Settings.degit.min_books}
  validate :borrow_date_must_be_before_expire_date
  validate :date_must_be_greater_than_current

  after_save :update_book_amount
  before_destroy :recalculate_book_amount

  scope :filter_by_status, ->(status){where(status:)}

  delegate :name, to: :user, prefix: true
  delegate :title, to: :book, prefix: true

  private

  def borrow_date_must_be_before_expire_date
    return unless
      borrow_date.present? && expire_date.present? && borrow_date > expire_date

    errors.add(:borrow_date,
               I18n.t("transactions.model.validates.compare_date"))
  end

  def update_book_amount
    remaining_books = book.book_amount.to_i - amount.to_i
    book.update_attribute(:book_amount, remaining_books)
  end

  def recalculate_book_amount
    new_book_amount = amount.to_i + book.book_amount.to_i
    book.update_column(:book_amount, new_book_amount)
  end

  def date_must_be_greater_than_current
    return unless borrow_date.present? && borrow_date <= Time.zone.today

    errors.add(:borrow_date, t("must_greater_date"))
  end
end
