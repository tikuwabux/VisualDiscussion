class Conclusion < ApplicationRecord
  belongs_to :agenda_board
  has_many :reasons, dependent: :destroy
  accepts_nested_attributes_for :reasons, allow_destroy: true

  validates :agenda_board_id, presence: true
  validates :conclusion_summary, presence: true
end
