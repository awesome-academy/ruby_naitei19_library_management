class Publisher < ApplicationRecord
  has_many :books, dependent: :nullify

  scope :filtered_by_name, lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  }
end
