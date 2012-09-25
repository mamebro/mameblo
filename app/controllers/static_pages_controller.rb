# -*- coding: utf-8 -*-
class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @entry  = current_brother.entries.build
      @feed_items = current_brother.feed.paginate(page: params[:page])
    else
      @res = Twitter.user_timeline("mameblo", {"count" => 1})
    end
  end
end
