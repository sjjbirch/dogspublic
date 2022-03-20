class Dog < ApplicationRecord

    belongs_to :user
    has_one :advert, dependent: :destroy

    validates :rname, length: { in: 5..100 }, uniqueness: true
    validates :cname, length: { in: 1..100 }
    validates :handler, length: { in: 5..100 }
    validates :sex, length: { is: 1 }
    validates :dob, presence: true

    scope :puppers, -> {where('dob > ?', 12.weeks.ago)}
    scope :males, -> { where(sex: "M")}
    scope :females, -> { where(sex: "F")}

    private

include ActionView::Helpers::SanitizeHelper
    def sanitize_all
       self.rname = sanitize(self.rname)
       self.cname = sanitize(self.cname)
       self.handler = sanitize(self.handler)
       self.sex = sanitize(self.sex)
    end

end
