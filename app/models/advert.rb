class Advert < ApplicationRecord
    belongs_to :dog

    validates :title, length: { in: 5..100 }
    validates :description, length: { in: 5..600 }

    private

    include ActionView::Helpers::SanitizeHelper
        def sanitize_all
           self.title = sanitize(self.title)
           self.description = sanitize(self.description)
        end
    
end
