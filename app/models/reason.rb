class Reason < ApplicationRecord
  belongs_to :conclusion
  has_many :evidences
  accepts_nested_attributes_for :evidences

  validates :reason_summary, presence: true
end
