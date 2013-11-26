class RelationshipsController < ApplicationController
  before_action :signed_in_brother

  def create
    @brother = Brother.find(params[:relationship][:followed_id])
    current_brother.follow!(@brother)
    redirect_to do |format|
      format.html { redirect_to @brother }
      format.js
    end
  end

  def destroy
    @brother = Relationship.find(params[:id]).followed
    current_brother.unfollow!(@brother)
    redirect_to do |format|
      format.html { redirect_to @brother }
      format.js
    end
  end
end
