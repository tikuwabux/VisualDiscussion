class Reason < ApplicationRecord
  belongs_to :conclusion
  has_many :evidences
end
