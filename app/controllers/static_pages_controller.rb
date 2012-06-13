class StaticPagesController < ApplicationController
  def home
    @user = User.new
    @entries = Entry.all
  end
end
