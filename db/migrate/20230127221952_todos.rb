class Todos < ActiveRecord::Migration[7.0]
  def up
    add_column :todos, :currentInteger, :integer
  end
end
