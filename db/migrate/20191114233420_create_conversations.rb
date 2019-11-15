class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :user_one, index: true 
      t.references :user_two, index: true

      t.timestamps
    end
  end
end
