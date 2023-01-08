class License < ApplicationRecord

  has_many :possession_licenses, dependent: :destroy

end
