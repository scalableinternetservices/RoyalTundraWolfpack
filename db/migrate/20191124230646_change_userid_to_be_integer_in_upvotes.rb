class ChangeUseridToBeIntegerInUpvotes < ActiveRecord::Migration[5.2]
  def change
    change_column :upvotes, :user_id, :integer
  end
end
