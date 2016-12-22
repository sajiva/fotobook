class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def follow_user
    @user = User.find_by(user_name: params[:user_name])
    if current_user.follow @user.id
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js {render :follow_user, :locals => {:user => @user}}
      end
    end
  end

  def unfollow_user
    @user = User.find_by(user_name: params[:user_name])
    if current_user.unfollow @user.id
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js {render :unfollow_user, :locals => {:user => @user}}
      end
    end
  end
end
