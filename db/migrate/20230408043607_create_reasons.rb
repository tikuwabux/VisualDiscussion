class CreateReasons < ActiveRecord::Migration[6.0]
  def change
    create_table :reasons do |t|
      t.integer :conclusion_id
      t.string :reason_summary
      t.text :reason_detail

      t.timestamps
    end
  end
end
