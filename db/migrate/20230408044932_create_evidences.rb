class CreateEvidences < ActiveRecord::Migration[6.0]
  def change
    create_table :evidences do |t|
      t.integer :reason_id
      t.string :evidence_summary
      t.text :evidence_detail

      t.timestamps
    end
  end
end
