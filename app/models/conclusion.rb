class Conclusion < ApplicationRecord
  belongs_to :agenda_board
  belongs_to :user
  has_many :reasons, dependent: :destroy
  accepts_nested_attributes_for :reasons, allow_destroy: true

  has_many :ref_conclusions

  has_one :opinion_position, foreign_key: 'argument_id', dependent: :destroy

  validates :conclusion_summary, presence: true
end
