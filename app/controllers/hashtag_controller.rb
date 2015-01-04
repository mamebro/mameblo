class HashtagController < ApplicationController
  def show
    @entries = Hashtag.find_by(name: params[:id]).entries.page params[:page]
    @entries.map{|entry| entry.content = entry.content_as_markdown}
  end
end
