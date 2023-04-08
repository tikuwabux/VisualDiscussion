class Reason < ApplicationRecord
  belong_to :conclusion
  has_many :evidences
end
