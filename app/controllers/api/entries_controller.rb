module Api
  class EntriesController < Api::ApplicationController
    def index
      entries = Entry.last(100)
      render json: entries
    end

    def show
      entry = Entry.find(params[:id])
      render json: entry
    end

    def home
      followee = current_brother.followed_brothers
      entries =
        Entry.where(brother_id: followee)
             .where("id > ?", params[:since_id] || 0)
             .where("id <= ?", params[:max_id] || Entry.first.try(:id) || 1)
             .limit(params[:count] || 20)

      render json: entries, meta: {
        _links: meta_links(entries)
      }
    end

    private
    def meta_links(entries)
      if entries.present?
        {
          latest: home_api_entries_url(since_id: entries.first.id, format: :json),
          previous: home_api_entries_url(max_id: entries.last.id-1, format: :json)
        }
      else
        {}
      end
    end
  end
end
