class JinjaController < ApplicationController
  def index
    @entry  = current_brother.entries.build
  end
end
