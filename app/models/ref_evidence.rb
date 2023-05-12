class RefEvidence < ApplicationRecord
  belongs_to :ref_reason

  validates :ref_evidence_summary, presence: true
end
