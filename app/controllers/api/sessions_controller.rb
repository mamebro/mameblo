module Api
  class SessionsController < Api::ApplicationController
    before_action :set_authentication, only: [:destroy]
    before_action :authenticate, only: [:destroy]

    def create
      brother = Brother.find_by_name(params[:name])
      if brother && brother.authenticate(params[:password])
        authentication = brother.authentications.first || brother.authentications.create
        render text: authentication.token, status: 200, content_type: Mime::TEXT
      else
        render nothing: true, status: 401
      end
    end

    def destroy
      @authentication.destroy!
      render nothing: true, status: 200
    end

    private
    def set_authentication
      @authentication = Authentication.find_by token: params[:auth_token]
    end
  end
end
