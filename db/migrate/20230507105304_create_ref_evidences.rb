class CreateRefEvidences < ActiveRecord::Migration[6.0]
  def change
    create_table :ref_evidences do |t|
      t.references :ref_reason, null: false, foreign_key: true
      t.string :ref_evidence_summary
      t.text :ref_evidence_detail

      t.timestamps
    end
  end
end
