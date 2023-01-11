class Message < ApplicationRecord

  belongs_to :room
  belongs_to :messageable, polymorphic: true

end
