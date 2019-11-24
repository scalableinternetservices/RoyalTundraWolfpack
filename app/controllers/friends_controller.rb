class FriendsController < ApplicationController
  before_action :authenticate_user!
  attr_accessor :friend_username

  def index
    @user = current_user
    @friends = @user.friends 
    @requests = @user.requested_friends
    @pending = @user.pending_friends
    @blocked = @user.blocked_friends

  end

  #send friend request 
  def create
    if params[:friendUsername]
      @user = current_user
      friend_username = params[:friends][:friend_username]
      if friend_username.nil?
        head 404
      else
        friend = User.find_by(username: friend_username)
        @user.friend_request(friend)

        respond_to do |format|
          if @user.save
            format.html { redirect_to friends_path, notice: 'Friend request was successfully sent.' }
            format.json { render :show, status: :created, location: friends_path}
          else
            format.html { redirect_to friends_path, notice: 'Friend request failed to be sent.'  }
            format.json { render json: @friend.errors, status: :unprocessable_entity }
          end
        end
      end
    else
    end
  end

  #accept friend request 
  def accept
    @user = current_user
    friend = User.find_by(id: params[:id])
    @user.accept_request(friend)

    respond_to do |format|
      if @user.save
        format.html { redirect_to friends_path, notice: 'Friend was successfully added.' }
        format.json { render :show, status: :created, location: friends_path}
      else
        format.html { redirect_to friends_path, notice: 'Friend failed to be added.' }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  def reject
    @user = current_user
    friend = User.find_by(id: params[:id])
    @user.decline_request(friend)

    respond_to do |format|
      if @user.save
        format.html { redirect_to friends_path, notice: 'Friend was successfully rejected.' }
        format.json { render :show, status: :created, location: friends_path}
      else
        format.html { redirect_to friends_path, notice: 'Friend failed to be rejected.' }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def remove 
    @user = current_user
    friend = User.find_by(id: params[:id])
    @user.remove_friend(friend)

    respond_to do |format|
      if @user.save
        format.html { redirect_to friends_path, notice: 'Friend was successfully removed.' }
        format.json { render :show, status: :created, location: friends_path}
      else
        format.html { redirect_to friends_path, notice: 'Friend failed to be removed.' }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

end
