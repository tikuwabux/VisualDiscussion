class Evidence < ApplicationRecord
  belongs_to :reason

  validates :evidence_summary, presence: true
end
