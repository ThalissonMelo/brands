class AddSendInvitesListToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :send_invites_list, :json
  end
end
