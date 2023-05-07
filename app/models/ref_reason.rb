class RefReason < ApplicationRecord
  belongs_to :ref_conclusion
  has_many :ref_evidences
end
