class OpinionPosition < ApplicationRecord
  belongs_to :argument, class_name: 'Conclusion', optional: true
end
