class HashtagController < ApplicationController
  def show
    @entries = Entry.where("content LIKE ?", "% ##{params[:id]} %")
    @entries = @entries.page params[:page]
  end
end
