class ScoreMailer < ActionMailer::Base
  default from: "score@mamebro.com"

  def daily
    staff_mail_list = if Rails.env.production?
                        YAML.load_file(Rails.root.to_s + '/config/staff_mail.yml')
                      else
                        ['dev@mamebro.com']
                      end
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

    @url  = Rails.env.production? ? 'http://www.mameblo.com/' : 'http://mameblo.dev/'
    @date = Time.now.yesterday.strftime('%Y年%m月%d日')

    mail(to: staff_mail_list,
         subject: "【まめぶろ】Daily スコアレポート #{@date}")
  end
end
