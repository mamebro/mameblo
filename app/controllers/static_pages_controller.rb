class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @entry  = current_brother.entries.build
      @feed_items = current_brother.feed.page params[:page]
    end
  end
end
