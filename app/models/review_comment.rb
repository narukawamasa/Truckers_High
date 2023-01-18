class ReviewComment < ApplicationRecord

  belongs_to :review
  belongs_to :driver

  validates :objective, presence: true
  validates :method, presence: true
  validates :baggage, presence: true
  validates :vehicle, presence: true
  validates :reception_time, presence: true
  validates :order, presence: true
  validates :waiting_place, presence: true



end
