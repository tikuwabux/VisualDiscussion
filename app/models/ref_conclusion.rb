class RefConclusion < ApplicationRecord
  belongs_to :agenda_board
  belongs_to :user
  has_many :ref_reasons, dependent: :destroy
  accepts_nested_attributes_for :ref_reasons, allow_destroy: true

  belongs_to :conclusion

  validates :agenda_board_id, presence: true
  validates :ref_conclusion_summary, presence: true
end
