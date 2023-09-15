class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :followable, polymorphic: true
  enum followable_type: {Publisher: "Publisher", Author: "Author"}

  before_validation :set_followable_type

  private
  def set_followable_type
    self.followable_type = followable.class.name
  end
end
