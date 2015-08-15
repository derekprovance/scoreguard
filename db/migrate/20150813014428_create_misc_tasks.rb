class CreateMiscTasks < ActiveRecord::Migration
  def change
    create_table :misc_tasks do |t|
      t.string  :name
      t.string  :description
      t.integer :weight
      t.integer :actual_points
      t.integer :total_points
      t.timestamps null: false
    end
  end
end
