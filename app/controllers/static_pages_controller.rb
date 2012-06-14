class StaticPagesController < ApplicationController
  def home

    @user = User.new
    @entries = Entry.order("created_at DESC")

    if signed_in?
      @entry = current_user.entries.build
    end
  end
end
