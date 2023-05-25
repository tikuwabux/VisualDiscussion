class AddConclusionIdToRefConclusions < ActiveRecord::Migration[6.0]
  def change
    add_reference :ref_conclusions, :conclusion, foreign_key: true
  end
end
