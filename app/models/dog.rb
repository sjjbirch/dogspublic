class Dog < ApplicationRecord
    belongs_to :user
    has_one :advert, dependent: :destroy

    scope :puppers, -> {where('dob > ?', 12.weeks.ago)}
    scope :males, -> { where(sex: "M")}
    scope :females, -> { where(sex: "F")}
end
