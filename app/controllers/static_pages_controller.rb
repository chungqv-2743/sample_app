class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.recent_posts.page(params[:page])
                              .per(Settings.item_in_page)
  end

  def help; end

  def about; end

  def contact; end
end
