class ConversationsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @recipients = User.all - [current_user]
  end

  def create
    # TODO: if user sending to person that already has conversation, use that conversation instead of starting new one
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, params[:body], params[:subject])
    redirect_to conversations_path(receipt.conversation)
  end

end
