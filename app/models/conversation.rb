class Conversation < ApplicationRecord
 #  	belongs_to :user_one, class_name: "User", :foreign_key => :user_one_id
 #  	belongs_to :user_two, class_name: "User", :foreign_key => :user_two_id
  	
 #  	has_many :messages, dependent: :destroy

	# scope :between, -> (user_one_id,user_two_id) do
	# 	where("(conversations.user_one_id = ? AND conversations.user_two_id =?) OR (conversations.user_one_id = ? AND conversations.user_two_id =?)", user_one_id,user_two_id, user_two_id, user_one_id)
	# end

end
