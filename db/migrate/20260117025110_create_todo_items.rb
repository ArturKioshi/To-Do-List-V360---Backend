class CreateTodoItems < ActiveRecord::Migration[8.1]
  def change
    create_table :todo_items do |t|
      t.string :title, null: false
      t.string :content
      t.boolean :completed, null: false, default: false
      t.datetime :due_date
      t.integer :priority, null: false, default: 0
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
