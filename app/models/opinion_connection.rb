class OpinionConnection < ApplicationRecord
  validates :source_id, presence: true
  validates :target_id, presence: true
end
