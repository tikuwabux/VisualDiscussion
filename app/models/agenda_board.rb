class AgendaBoard < ApplicationRecord
  belongs_to :user
  has_many :conclusions
  has_many :ref_conclusions

  validates :agenda, presence: true, uniqueness: true
end
