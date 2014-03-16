module Api
  class SessionsController < Api::ApplicationController
    skip_before_action :authenticate, only: [:create]

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
  end
end
