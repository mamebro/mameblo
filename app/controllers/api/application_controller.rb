module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    private
    def authenticate
      unless @authentication && @authentication.brother.name == params[:name]
        render nothing: true, status: 401
      end
    end
  end
end
