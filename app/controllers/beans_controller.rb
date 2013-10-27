class BeansController < ApplicationController

  def create
    Beans.create(entry_id: params[:entry_id], throw_brother_id: current_brother.id)
    @beans = Beans.where(entry_id: params[:entry_id]);
    redirect_to entry_path
  end

  def destroy
  end
end
