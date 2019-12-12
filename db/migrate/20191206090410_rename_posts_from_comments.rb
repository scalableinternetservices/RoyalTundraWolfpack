class RenamePostsFromComments < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :comments, :posts, index: true, foreign_key: true
  	add_reference :comments, :post, index: true, foreign_key: true
  end
end
