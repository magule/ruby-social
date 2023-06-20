  class ProfileController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    def show
      @user = User.find_by(id: params[:id])
      if @user.nil?
        redirect_to root_path, notice: 'User not found'
        return
      end

      @notes = @user.notes
      @collections = @user.collections


      # Add the following line to fetch the current user's collections
      @current_user_collections = current_user.collections
    end


  def follow
    current_user.send_follow_request_to(@user)
    redirect_to profile_path(@user)
  end

  def unfollow
    make_it_a_unfriend_request

    current_user.unfollow(@user)
    redirect_to profile_path(@user)


  end

  def accept
    current_user.accept_follow_request_of(@user)
    #make_it_a_ufriend_request
    make_it_a_friend_request

    redirect_to root_path

  end

  def decline
    current_user.decline_follow_request_of(@user)
    redirect_to root_path
  end


  def cancel
    current_user.remove_follow_request_for(@user)
    redirect_to root_path
  end


      private


      def make_it_a_friend_request
        current_user.send_follow_request_to(@user)
        @user.accept_follow_request_of(current_user)

      end


      def make_it_a_unfriend_request
        #@user.unfollow(current_user) if current_user.mutual_following_with?(@user)
        #@user.unfollow(current_user) if @user.mutual_following_with?(current_user)
        @user.unfollow(current_user) if @user.mutual_following_with?(current_user)
      end



      def set_user
        @user = User.find(params[:id])
      end
  end
