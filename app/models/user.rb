class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

 	acts_as_messageable

 	def name
 		"User #{id}"
 	end

 	def mailboxer_email(object)
		nil
	end


	has_many :conversations
	has_many :messages

	validates :username, presence: true
	validates :username, uniqueness: true, if: -> { self.username.present? }

	# validates :username, uniqueness: true
end
