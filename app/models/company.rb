class Company < ApplicationRecord

  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def address_display
  '〒' + postal_code + ' ' + address
  end

  def negative_comments_count
    comments_count = 0
    reviews.each do |review|
      review.review_comments.each do |comment|
        if comment.score != nil
          if comment.score <= -0.1 && comment.deletion == false
            comments_count += 1
          end
        end
      end
    end
    return comments_count
  end

end
