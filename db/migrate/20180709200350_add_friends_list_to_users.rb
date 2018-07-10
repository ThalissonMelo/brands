class AddFriendsListToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :friends_list, :json   
  end
end
