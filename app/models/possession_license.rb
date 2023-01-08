class PossessionLicense < ApplicationRecord

  belongs_to :driver
  belongs_to :license

end
