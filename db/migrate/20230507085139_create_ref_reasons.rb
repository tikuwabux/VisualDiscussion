class CreateRefReasons < ActiveRecord::Migration[6.0]
  def change
    create_table :ref_reasons do |t|
      t.references :ref_conclusion, null: false, foreign_key: true
      t.string :ref_reason_summary
      t.text :ref_reason_detail

      t.timestamps
    end
  end
end
