class Review < ApplicationRecord

  belongs_to :driver
  belongs_to :company
  
  enum objective: { wholesale: 0, loading: 1, other: 2 }

end
