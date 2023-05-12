class CreateRefConclusions < ActiveRecord::Migration[6.0]
  def change
    create_table :ref_conclusions do |t|
      t.references :agenda_board, null: false, foreign_key: true
      t.string :ref_conclusion_summary
      t.text :ref_conclusion_detail

      t.timestamps
    end
  end
end
