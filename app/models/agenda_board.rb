class AgendaBoard < ApplicationRecord
  belongs_to :user
  has_many :conclusions
end
