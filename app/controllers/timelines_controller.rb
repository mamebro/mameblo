class TimelinesController < ApplicationController
  def index
    if signed_in?
      @entry  = current_brother.entries.build
      @entries = Entry.where.not(brother_id: current_brother.id).page params[:page]
      @entries.each_with_index do |entry, index|
        @entries[index].content = entry.content_as_markdown
      end
    end
  end
end
