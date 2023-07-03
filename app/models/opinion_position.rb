class OpinionPosition < ApplicationRecord
  belongs_to :argument, class_name: 'Conclusion', optional: true
  belongs_to :refutation, class_name: 'RefConclusion', optional: true
end
