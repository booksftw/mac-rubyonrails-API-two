class RemoveCurrentInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :todos, :currentInteger
  end
end
