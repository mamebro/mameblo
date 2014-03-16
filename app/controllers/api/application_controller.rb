module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :set_authentication
    before_action :authenticate

    private
    def authenticate
      unless @authentication && @authentication.brother.name == params[:name]
        render nothing: true, status: 401
      end
    end

    def set_authentication
      @authentication = Authentication.find_by token: params[:auth_token]
    end
  end
end
