class AddUserValuesToTables < ActiveRecord::Migration
  def change
    add_column :goals, :user_id, :integer
    add_column :grades, :user_id, :integer
    add_column :misc_tasks, :user_id, :integer
  end
end
