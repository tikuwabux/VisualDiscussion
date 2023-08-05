class AddUniqueIndexToAgndaBoardsAgenda < ActiveRecord::Migration[6.0]
  def change
    add_index :agenda_boards, :agenda, unique: true
  end
end
