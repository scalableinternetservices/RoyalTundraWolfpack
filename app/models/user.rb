class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
 	# devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

 	acts_as_messageable

 	def name
 		"User #{id}"
 	end

 	def mailboxer_email(object)
		nil
	end

	has_many :conversations
	has_many :messages
end
