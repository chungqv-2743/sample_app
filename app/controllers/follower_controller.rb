class FollowerController < ApplicationController
  before_action :logged_in_user, only: %i(show)

  def show
    @title = t "followers"
    @user = User.find_by id: params[:id]
    @users = @user.followers
                  .page(params[:page])
                  .per(Settings.item_in_page)
    render "users/show_follow"
  end
end
