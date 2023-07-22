class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.date :finished_at
      t.date :deadline

      t.timestamps
    end
  end
end
