class License < ApplicationRecord

  has_many :possession_licenses, dependent: :destroy

  validates :name, presence: true


end
