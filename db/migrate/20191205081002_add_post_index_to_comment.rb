class AddPostIndexToComment < ActiveRecord::Migration[5.2]
  def change
  	add_reference :comments, :posts, index: true, foreign_key: true
  end
end
