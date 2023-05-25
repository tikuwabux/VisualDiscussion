class AddParentRefConclusionIdToRefConclusions < ActiveRecord::Migration[6.0]
  def change
    add_reference :ref_conclusions, :parent_ref_conclusion, foreign_key: { to_table: :ref_conclusions }
  end
end
