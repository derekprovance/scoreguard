class AddUserIdToApis < ActiveRecord::Migration
  def change
    add_column :app_apis, :user_id, :integer
  end
end
