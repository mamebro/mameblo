class BeansController < ApplicationController
  def create
    Beans.create(entry_id: params[:entry_id], throw_brother_id: current_brother.id)
    render 'entries/show'
  end

  def destroy
  end
end
