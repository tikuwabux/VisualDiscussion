class Reason < ApplicationRecord
  belongs_to :conclusion
  has_many :evidences, dependent: :destroy
  accepts_nested_attributes_for :evidences, allow_destroy: true

  validates :reason_summary, presence: true
end
