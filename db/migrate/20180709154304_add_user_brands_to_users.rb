class AddUserBrandsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_follow_brands, :json
  end
end
