class RefReason < ApplicationRecord
  belongs_to :ref_conclusion
  has_many :ref_evidences, dependent: :destroy
  accepts_nested_attributes_for :ref_evidences, allow_destroy: true

  validates :ref_reason_summary, presence: true
end
