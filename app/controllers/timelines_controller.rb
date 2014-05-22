class TimelinesController < ApplicationController
  def index
    if signed_in?
      @entry  = current_brother.entries.build
      @entries = Entry.where.not(brother_id: current_brother.id).page params[:page]
    else
      @entries = Entry.page params[:page]
    end
    @entries.map{|e| e.content_as_markdown}
  end
end
