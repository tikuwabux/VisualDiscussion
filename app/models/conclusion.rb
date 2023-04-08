class Conclusion < ApplicationRecord
  belong_to :agenda_board
  has_many :reasons
end
