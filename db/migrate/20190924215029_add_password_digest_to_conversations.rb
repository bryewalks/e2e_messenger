class AddPasswordDigestToConversations < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :password_digest, :string
  end
end
