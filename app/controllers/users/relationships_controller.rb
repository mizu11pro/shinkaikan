class Users::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followers
  end
end
