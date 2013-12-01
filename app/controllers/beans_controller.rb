class BeansController < ApplicationController

  def create
    Beans.create(entry_id: params[:entry_id], throw_brother_id: current_brother.id)
    render nothing: true
  end

  def destroy
  end
end
