class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_name(params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      response = { :result => "success" }
      respond_to do |format|
        format.json { render :json => response }
      end
      sign_in user
      redirect_to root_path
    else
      response = { :result => "failure" }
      respond_to do |format|
        format.json { render :json => response }
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
