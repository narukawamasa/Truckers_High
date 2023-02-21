class Contact < ApplicationRecord

  validates :contactable_id, presence: true
  validates :contactable_type, presence: true
  validates :category, presence: true
  validates :text, presence: true
  validates :status, presence: true

  enum category: { edit: 0, deletion: 1, other: 2 }
  enum status: { confirmation: 0, verified: 1, fixed: 2}


end
