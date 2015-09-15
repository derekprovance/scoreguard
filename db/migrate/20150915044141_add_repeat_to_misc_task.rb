class AddRepeatToMiscTask < ActiveRecord::Migration
  def change
    add_column :misc_tasks, :repeat, :boolean, :default => false
    add_column :misc_tasks, :disabled, :boolean, :default => false
  end
end
