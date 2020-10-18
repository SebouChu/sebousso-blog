class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper

  self.abstract_class = true
end
