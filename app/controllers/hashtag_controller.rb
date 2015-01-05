class HashtagController < ApplicationController
  def show
    if hashtag = Hashtag.find_by(name: params[:id])
      @hashtag_name = hashtag.name
      @entries = hashtag.entries.page params[:page]
      @entries.map{|entry| entry.content = entry.content_as_markdown}
    else
      redirect_to root_url
    end
  end
end
