class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_validation :sanitize_all
end
