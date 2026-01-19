class ChangePriorityDefaultInTodoItems < ActiveRecord::Migration[8.1]
  def up
    change_column_default :todo_items, :priority, from: 0, to: 1

    execute "UPDATE todo_items SET priority = 1 WHERE priority = 0"
  end

  def down
    change_column_default :todo_items, :priority, from: 1, to: 0

    execute "UPDATE todo_items SET priority = 0 WHERE priority = 1"
  end
end
