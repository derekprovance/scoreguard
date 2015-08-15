class AddActiveToMiscTasks < ActiveRecord::Migration
  def change
    add_column :misc_tasks, :active, :boolean
  end
end
