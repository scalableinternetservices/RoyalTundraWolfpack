class Post < ApplicationRecord
	validates :title, presence: { message: "cannot be empty" }
	validates :author, presence: { message: "cannot be empty" }
	validates :content, presence: { message: "cannot be empty" }
	belongs_to :book
	has_many :upvotes, dependent: :destroy
	has_many :comments, as: :commentable

	def score
		upvotes.count
	end
end
