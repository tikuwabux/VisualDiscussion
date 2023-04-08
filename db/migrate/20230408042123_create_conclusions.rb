class CreateConclusions < ActiveRecord::Migration[6.0]
  def change
    create_table :conclusions do |t|
      t.integer :agenda_board_id
      t.string :conclusion_summary
      t.text :conclusion_detail

      t.timestamps
    end
  end
end
