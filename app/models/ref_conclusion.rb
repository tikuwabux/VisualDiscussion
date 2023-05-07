class RefConclusion < ApplicationRecord
  belongs_to :agenda_board
  has_many :ref_reasons
end
