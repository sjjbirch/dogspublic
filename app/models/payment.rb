class Payment < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, class_name: 'User'


  def sanitize_all
    # users have no input here
   end
end
