class Todos < ActiveRecord::Migration[7.0]
  def up
    add_column :todos, :currentIndex, :integer
  end

  def down
    remove_column :todos, :currentIndex
  end
end
