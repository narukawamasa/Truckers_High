class Message < ApplicationRecord

  belongs_to :room
  belongs_to :messageable, polymorphic: true
  has_one :notification

  validates :message, presence: true

end
