class Dog < ApplicationRecord
    belongs_to :user
    has_one :advert, dependent: :destroy
end
