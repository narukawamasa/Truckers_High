class ReviewComment < ApplicationRecord

  belongs_to :review
  belongs_to :driver


end
