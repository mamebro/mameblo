class Tent::HomeController < Tent::BaseController
  def index
    yesterday            = Time.now.yesterday.all_day
    day_before_yesterday = Time.now.yesterday.yesterday.all_day
    @brother_yesterday            = Brother.where(created_at: yesterday)
    @brother_day_before_yesterday = Brother.where(created_at: day_before_yesterday)
    @brother_diff                 = @brother_yesterday.count - @brother_day_before_yesterday.count
    @brother_total                = Brother.where("created_at <= ?" ,Time.now.yesterday.end_of_day).count

    @entry_yesterday              = Entry.where(created_at: yesterday)
    @entry_day_before_yesterday   = Entry.where(created_at: day_before_yesterday)
    @entry_diff                   = @entry_yesterday.count - @entry_day_before_yesterday.count
    @entry_total                  = Entry.where("created_at <= ?" ,Time.now.yesterday.end_of_day).count

    @beans_yesterday              = Bean.where(created_at: yesterday)
    @beans_day_before_yesterday   = Bean.where(created_at: day_before_yesterday)
    @beans_diff                   = @beans_yesterday.count - @beans_day_before_yesterday.count
    @beans_total                  = Bean.count

    @brothers = Brother.all
    @entries  = Entry.all

    @url  = Rails.env.production? ? 'http://mameblo.com/' : 'http://mameblo.dev/'
    @date = Time.now.yesterday.strftime('%Y年%m月%d日')
  end
end
