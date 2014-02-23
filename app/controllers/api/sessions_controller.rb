module Api
  class SessionsController < Api::ApplicationController
    before_action :set_api_authentication, only: [:destroy]
    before_action :authenticate, only: [:destroy]

    def create
      brother = Brother.find_by_name(params[:name])
      if brother && brother.authenticate(params[:password])
        authentication = brother.api_authentications.first || brother.api_authentications.create
        render text: authentication.token, status: 200, content_type: Mime::TEXT
      else
        render nothing: true, status: 401
      end
    end

    def destroy
      @api_authentication.destroy!
      render nothing: true, status: 200
    end

    private
    def set_api_authentication
      @api_authentication = ApiAuthentication.find_by token: params[:auth_token]
    end

    def authenticate
      unless @api_authentication && @api_authentication.brother.name == params[:name]
        render nothing: true, status: 401
      end
    end
  end
end
