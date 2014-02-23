module Api
  class SessionsController < Api::ApplicationController
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
    end

    private
    def authenticate
      api_authentication = ApiAuthentication.find_by token: params[:token]
      unless api_authentication && api_authentication.brother.name == params[:user]
        render nothing: true, status: 401
      end
    end
  end
end
