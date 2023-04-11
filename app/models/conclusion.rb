class Conclusion < ApplicationRecord
  belongs_to :agenda_board
  has_many :reasons
  accepts_nested_attributes_for :reasons

  validates :agenda_board_id, presence: true
  validates :conclusion_summary, presence: true
end
