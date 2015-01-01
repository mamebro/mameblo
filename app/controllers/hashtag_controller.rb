class HashtagController < ApplicationController
  def show
    @entries = Entry.where("content LIKE ?", "%##{params[:id]}%")
    @entries = @entries.page params[:page]
    @entries.map{|entry| entry.content = entry.content_as_markdown}
  end
end
