class CreateTodoLists < ActiveRecord::Migration[8.1]
  def change
    create_table :todo_lists do |t|
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
