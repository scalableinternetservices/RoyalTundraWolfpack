class Post < ApplicationRecord
	validates :title, presence: { message: "cannot be empty" }
	validates :author, presence: { message: "cannot be empty" }
	validates :upvotes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :content, presence: { message: "cannot be empty" }
end
