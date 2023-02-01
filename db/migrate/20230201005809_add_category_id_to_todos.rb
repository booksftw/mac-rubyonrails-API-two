class AddCategoryIdToTodos < ActiveRecord::Migration[7.0]
  def change
    add_column :todos, :category_id, :integer
  end
end
