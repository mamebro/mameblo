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

  def brothers
    if signed_in?
      @entry = current_brother.entries.build
      followed_ids = []
      Relationship.where(follower_id: current_brother.id).each do |rel|
        followed_ids << rel.followed_id
      end
      @entries = Entry.where(brother_id: followed_ids).page params[:page]
      @entries.map{|e| e.content_as_markdown}
    end
  end
end
