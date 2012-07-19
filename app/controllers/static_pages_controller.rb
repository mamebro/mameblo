class StaticPagesController < ApplicationController
  def home
    @user = User.new
#    @entries = Entry.order("created_at DESC")

    if signed_in?
      @entry  = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
