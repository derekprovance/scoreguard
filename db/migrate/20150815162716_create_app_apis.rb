class CreateAppApis < ActiveRecord::Migration
  enable_extension "hstore"
  
  def change
    create_table :app_apis do |t|
      t.string :name
      t.datetime :last_updated
      t.hstore :api_keys

      t.timestamps null: false
    end
  end
end
