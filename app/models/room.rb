class Room < ApplicationRecord

  belongs_to :driver
  belongs_to :transport_company

end
