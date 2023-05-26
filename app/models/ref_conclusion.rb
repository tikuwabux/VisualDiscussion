class RefConclusion < ApplicationRecord
  belongs_to :agenda_board
  belongs_to :user
  has_many :ref_reasons, dependent: :destroy
  accepts_nested_attributes_for :ref_reasons, allow_destroy: true

  belongs_to :conclusion, optional: true

  belongs_to :parent_ref_conclusion, class_name: 'RefConclusion', optional: true, foreign_key: 'parent_ref_conclusion_id'
  has_many :child_ref_conclusions, class_name: 'RefConclusion', foreign_key: 'parent_ref_conclusion_id'

  validates :agenda_board_id, presence: true
  validates :ref_conclusion_summary, presence: true
end
