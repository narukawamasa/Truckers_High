class TransportCompany < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one_attached :profile_image

  has_many :drivers
  has_many :rooms
  has_many :messages, as: :messageable

  validates :email, presence: true
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true


  def exsits_uncheck_messages?
    #通知機能の為
    result = false
    rooms.each do | room |
      room.messages.each do |message|
        if message.messageable_type == "Driver"
          if message.notification.confirmation_status == false
            result = true
          end
        end
      end
    end

    result
  end


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

  # def self.looks(search, word)
  #   if search == "perfect_match"
  #     @transport_companies = TransportCompany.where("name LIKE?", "#{word}")
  #     #@word_true = @word
  #   elsif search == "forward_match"
  #     @transport_companies = TransportCompany.where("name LIKE?","#{word}%")
  #     #@word_true = @word
  #   elsif search == "backward_match"
  #     @transport_companies = TransportCompany.where("name LIKE?","%#{word}")
  #     #@word_true = @word
  #   elsif search == "partial_match"
  #     @transport_companies = TransportCompany.where("name LIKE?","%#{word}%")
  #     #@word_true = @word
  #   else
  #     @transport_companies = TransportCompany.all
  #     #@word_error = @word
  #   end
  # end

end
