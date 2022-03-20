class Litter < ApplicationRecord
    before_validation :in_past?

    has_many_attached :gallery_image, dependent: :purge_later

    validates :identifier, format: { without: /\s/, 
    message: "No whitespace allowed in litter names." }, uniqueness: true
    validates :planned_date, presence: true
    validates :expected_date, presence: true
    validates :expected_size, numericality: { only_integer: true, allow_nil: true, less_than: 15, greater_than: 0 }
    validates :actual_size, numericality: { only_integer: true, allow_nil: true, less_than: 15, greater_than: -1 }
    
    def in_past?
        unless self.actual_date.nil?
            if self.actual_date.future?
                throw :abort
            end
        end
    end

    private

    include ActionView::Helpers::SanitizeHelper
        def sanitize_all
           self.identifier = sanitize(self.identifier)
        end

end
