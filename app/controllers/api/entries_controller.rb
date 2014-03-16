module Api
  class EntriesController < Api::ApplicationController
    before_action :authenticate

    def show
      entry = Entry.find(params[:id])
      render json: entry
    end

    def home
    end
  end
end
