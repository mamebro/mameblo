module Api
  class EntriesController < Api::ApplicationController
    def show
      entry = Entry.find(params[:id])
      render json: entry
    end

    def home
    end
  end
end
