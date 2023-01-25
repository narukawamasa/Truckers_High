class Driver < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image

  belongs_to :transport_company, optional: true
  # optional: true でnilを許容し、バリデーションに引っかからないようにする
  has_many :possession_licenses, inverse_of: :driver, dependent: :destroy
  accepts_nested_attributes_for :possession_licenses, allow_destroy: true
  has_many :bookmarks, dependent: :destroy
  has_many :reviews
  has_many :review_comments
  has_many :rooms
  has_many :messages, as: :messageable



  def exsits_uncheck_messages?
    #通知機能の為
    result = false
    rooms.each do | room |
      room.messages.each do |message|
        if message.messageable_type == "TransportCompany"
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

  # def update_without_current_password(params, *options)
  #   params.delete(:current_password)

  #   if params[:password].blank? && params[:password_confirmation].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation)
  #   end

  #   result = update_attributes(params, *options)
  #   clean_up_passwords
  #   result
  # end

  def name
    family_name + first_name
  end

end
