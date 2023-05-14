class AddUserIdToConclusions < ActiveRecord::Migration[6.0]
  def change
    add_reference :conclusions, :user, foreign_key: true
  end
end
