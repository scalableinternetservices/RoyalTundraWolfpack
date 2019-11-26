class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :commentable, polymorphic: true
	has_many :comments, as: :commentable

	def commentCount
		total = comments.count
		comments.each do |child_comment|
			total += child_comment.commentCount
		end
		return total
  end
end
