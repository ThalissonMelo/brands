class AddFriendshipInvitationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :friendship_invitations, :json
  end
end
