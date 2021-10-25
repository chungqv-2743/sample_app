class FollowedController < ApplicationController
  before_action :logged_in_user, only: %i(show)
  def show
    @title = t "following"
    @user = User.find_by id: params[:id]
    @users = @user.following
                  .page(params[:page])
                  .per(Settings.item_in_page)
    render "users/show_follow"
  end
end
