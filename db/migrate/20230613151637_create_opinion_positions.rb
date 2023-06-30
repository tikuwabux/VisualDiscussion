class CreateOpinionPositions < ActiveRecord::Migration[6.0]
  def change
    create_table :opinion_positions do |t|
      t.references :argument, null: true, foreign_key: { to_table: :conclusions }
      t.references :refutation, null: true, foreign_key: { to_table: :ref_conclusions }
      t.integer :left
      t.integer :top

      t.timestamps
    end
  end
end
