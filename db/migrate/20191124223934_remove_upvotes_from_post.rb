class RemoveUpvotesFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :upvotes, :integer
  end
end
