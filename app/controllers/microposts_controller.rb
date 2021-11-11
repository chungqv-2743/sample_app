class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :build_micropost, only: :create
  def create
    if @micropost.save
      flash[:success] = t ".micropost_created"
      redirect_to root_url
    else
      flash[:danger] = t ".micropost_created_fail"
      @feed_items = current_user.feed.recent_posts.page(params[:page])
                                .per Settings.max_item_per_page
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".micropost_deleted"
    else
      flash[:danger] = t ".deleted_fail"
    end
    redirect_to request.referer || root_url
  end

  private
  def micropost_params
    params.require(:micropost).permit Micropost::ATTR_CHANGE
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t "micropost_invalid"
    redirect_to request.referer || root_url
  end

  def build_micropost
    @micropost = current_user.microposts.build micropost_params
  end
end
