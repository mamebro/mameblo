class BeansController < ApplicationController

  def create
    Bean.create(entry_id: params[:entry_id], throw_brother_id: current_brother.id)
    render nothing: true
  end
end
