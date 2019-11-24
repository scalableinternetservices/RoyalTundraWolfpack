class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

 	acts_as_messageable

	has_friendship

 	def name
 		"User #{id}"
 	end

 	def mailboxer_email(object)
		nil
	end

	def friends?
		self.friends
	end
	
	def friend_requests?
		self.requested_friends.any?
	end

	def requested_friends?
		self.pending_friends.any?
	end

	def invite_friend(user)
		self.friend_request(user)
	end

	def not_friends
        potential = []
        User.all.each do |user|
            if(self.friends_with?(user) != true && self != user && self.friends.include?(user) != true && self.pending_friends.include?(user) != true && self.requested_friends.include?(user) != true)
                potential << user
            end
        end
        potential
    end


	has_many :conversations
	has_many :messages

	has_many :comments

	validates :username, presence: true
	validates :username, uniqueness: true, if: -> { self.username.present? }

	# validates :username, uniqueness: true
end
