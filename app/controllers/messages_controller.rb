class MessagesController < ApplicationController
  # # before_action :set_message, only: [:show, :edit, :update, :destroy]
  # before_action do
  #   @conversation = Conversation.find(params[:conversation_id])
  #   @recipient = User.find(params[:recipient_id])
  # end

  # # GET /messages
  # # GET /messages.json
  # def index
  #   # @messages = Message.all
  #   @messages = @conversation.messages
  #   # if @messages.length > 10
  #   #  @over_ten = true
  #   #  @messages = @messages[-10..-1]
  #   # end
  #   if params[:m]
  #    # @over_ten = false
  #    @messages = @conversation.messages
  #   end
  #   # if @messages.last
  #   #   if @messages.last.user_id != current_user.id
  #   #     @messages.last.read = true;
  #   #   end
  #   # end
  #   @message = @conversation.messages.new
  # end

  # # GET /messages/1
  # # GET /messages/1.json
  # def show
  # end

  # # GET /messages/new
  # def new
  #   # @message = Message.new
  #   # @message = @conversation.messages.new]
  #   # if @message.save
  #   #   redirect_to conversation_messages_path(@conversation)
  #   # end
  #   @message = @conversation.messages.new
  # end

  # # GET /messages/1/edit
  # def edit
  # end

  # # POST /messages
  # # POST /messages.json
  # def create
  #   # @message = Message.new(message_params)

  #   # respond_to do |format|
  #   #   if @message.save
  #   #     format.html { redirect_to @message, notice: 'Message was successfully created.' }
  #   #     format.json { render :show, status: :created, location: @message }
  #   #   else
  #   #     format.html { render :new }
  #   #     format.json { render json: @message.errors, status: :unprocessable_entity }
  #   #   end
  #   # end
  #   @message = @conversation.messages.new(message_params)
  #   @message.recipient_id = @recipient.id
  #   if @message.save
  #     redirect_to conversation_messages_path(@conversation)
  #   end
  # end

  # # PATCH/PUT /messages/1
  # # PATCH/PUT /messages/1.json
  # def update
  #   respond_to do |format|
  #     if @message.update(message_params)
  #       format.html { redirect_to @message, notice: 'Message was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @message }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @message.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /messages/1
  # # DELETE /messages/1.json
  # def destroy
  #   @message.destroy
  #   respond_to do |format|
  #     format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_message
  #     @message = Message.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def message_params
  #     # params.require(:message).permit(:sender_id, :recipient_id, :conversation_id, :message)
  #     prarms.require(:message).permit(:message, :sender_id, :recipient_id)
  #   end
  before_action :set_conversation

  def create

    receipt = current_user.reply_to_conversation(@conversation, params[:body])
    redirect_to conversation_path(receipt.conversation)
  end

  private
    def set_conversation
      @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
    end
end
