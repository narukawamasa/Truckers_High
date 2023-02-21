class Review < ApplicationRecord

  belongs_to :driver
  belongs_to :company
  has_many :review_comments, dependent: :destroy

  validates :objective, presence: true
  validates :method, presence: true
  validates :baggage, presence: true
  validates :vehicle, presence: true
  validates :reception_time, presence: true
  validates :order, presence: true
  validates :waiting_place, presence: true

  enum objective: { wholesale: 0, loading: 1, other: 2 }

  def negative_comments_count
    comments_count = 0
      review_comments.each do |comment|
        if comment.score != nil
          if comment.score <= -0.1 && comment.deletion == false
            comments_count += 1
          end
        end
      end
    return comments_count
  end



end
