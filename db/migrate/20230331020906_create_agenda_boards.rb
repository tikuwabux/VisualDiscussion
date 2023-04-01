class CreateAgendaBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :agenda_boards do |t|
      t.integer :user_id
      t.string :agenda
      t.string :category

      t.timestamps
    end
  end
end
