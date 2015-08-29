class AddCategoriesToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :category, :string, :default => ''
  end
end
