class Users::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :destroy, :followers, :followings]

  def create
    current_user.follow(params[:user_id])
  end

  def destroy
    current_user.unfollow(params[:user_id])
  end

  def followers
    @users = @user.followings
  end

  def followings
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end