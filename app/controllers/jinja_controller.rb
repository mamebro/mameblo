class JinjaController < ApplicationController
  def index
    @entry  = current_brother.entries.build if signed_in?
  end
end
