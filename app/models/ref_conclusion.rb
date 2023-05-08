class RefConclusion < ApplicationRecord
  belongs_to :agenda_board
  has_many :ref_reasons
  accepts_nested_attributes_for :ref_reasons

  validates :agenda_board_id, presence: true
  validates :ref_conclusion_summary, presence: true
end
