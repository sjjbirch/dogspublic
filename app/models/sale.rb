class Sale < ApplicationRecord
  belongs_to :seller_id
  belongs_to :buyer_id
end
