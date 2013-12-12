class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @entry  = current_brother.entries.build
      followed_ids = []
      Relationship.where(follower_id: current_brother.id).each do |rel|
        followed_ids << rel.followed_id
      end
      @entries = Entry.where(brother_id: followed_ids).page params[:page]
      @entries.each_with_index do |entry, index|
        @entries[index].content = entry.content_as_markdown
      end
    end
  end
end
