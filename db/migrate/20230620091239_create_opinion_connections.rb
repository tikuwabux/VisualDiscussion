class CreateOpinionConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :opinion_connections do |t|
      t.string :source_id
      t.string :target_id
      t.string :source_endpoint_id
      t.string :target_endpoint_id
    end
  end
end
