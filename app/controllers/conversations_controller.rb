class ConversationsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @recipient = (@conversation.recipients - [current_user])[0].email
  end

  def new
    # @recipients = []
    # User.all.each do |u| 
    #   if u != current_user
    #     ongoing_conversation = Mailboxer::Conversation.between(u, current_user).find{|c| c.participants.count == 2 }
    #     if not ongoing_conversation.present?
    #       @recipients.append(u)
    #     end
    #   end
    # end
    @recipients = User.all - [current_user]
    # Conversation.participant(@a).participant(@b)
    # ADD FILTER FOR NOT ALLOWING NEW CONVOS W PPL WHO ALREADY HAVE CONVO WITH YOU
  end

  def create
    # TODO: if user sending to person that already has conversation, use that conversation instead of starting new one
    recipient = User.find(params[:user_id])
    ongoing_conversation = Mailboxer::Conversation.between(recipient, current_user).find{|c| c.participants.count == 2 }
    if ongoing_conversation.present?
      receipt = current_user.reply_to_conversation(ongoing_conversation, params[:body])
      redirect_to conversation_path(receipt.conversation)
    else
      receipt = current_user.send_message(recipient, params[:body], params[:subject])
      redirect_to conversation_path(receipt.conversation)
    end
  end
end
