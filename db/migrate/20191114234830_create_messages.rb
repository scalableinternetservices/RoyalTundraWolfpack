class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :sender, index: true
      t.references :recipient, index: true
      t.references :conversation, foreign_key: true
      t.string :message

      t.timestamps
    end
    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :recipient_id
  end
end
