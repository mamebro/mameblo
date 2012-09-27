# -*- coding: utf-8 -*-
class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @entry  = current_brother.entries.build
      @feed_items = current_brother.feed.paginate(page: params[:page])
    else
      begin
        res = Twitter.user_timeline("mameblo", {"count" => 1})
        @res = res.text
      rescue
        @res = "まめまめまめまめまめぶろ♪"
      end
    end
  end
end
