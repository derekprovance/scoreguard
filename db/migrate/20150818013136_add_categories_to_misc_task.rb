class AddCategoriesToMiscTask < ActiveRecord::Migration
  def change
    add_column :misc_tasks, :category, :string
  end
end
