class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :sender_id
      t.string :recipient_id

      t.timestamps
    end
  end
end
