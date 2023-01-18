class ReviewComment < ApplicationRecord

  belongs_to :review
  belongs_to :driver

  validates :comment, presence: true




end
