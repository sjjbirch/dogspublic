class Litter < ApplicationRecord

    has_many_attached :gallery_image, dependent: :purge_later
    validates :identifier, format: { without: /\s/, 
    message: "No whitespace allowed in litter names." }
end
