class RefReason < ApplicationRecord
  belongs_to :ref_conclusion
  has_many :ref_evidences
  accepts_nested_attributes_for :ref_evidences

  validates :ref_reason_summary, presence: true
end
