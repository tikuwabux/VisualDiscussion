class UpdateOpinionConnections < ActiveRecord::Migration[6.0]
  def change
    change_table :opinion_connections do |t|
      t.remove :source_endpoint_id, :target_endpoint_id
      t.timestamps
    end
  end
end
