class AddAssigneeToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :assignee, :string
  end
end
