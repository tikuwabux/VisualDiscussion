class Conclusion < ApplicationRecord
  belongs_to :agenda_board
  has_many :reasons
end
