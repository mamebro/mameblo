class ScoreMailer < ActionMailer::Base
  default from: "score@mamebro.com"

  def daily
    staff_mail_list = YAML.load_file(Rails.root.to_s + '/config/staff_mail.yml')

    yesterday            = Time.now.yesterday.all_day
    day_before_yesterday = Time.now.yesterday.yesterday.all_day

    @brother_yesterday_count      = Brother.where(created_at: yesterday).count
    @brother_day_before_yesterday = Brother.where(created_at: day_before_yesterday).count
    @brother_diff                 = @brother_day_before_yesterday - @brother_yesterday_count
    @brother_total                = Brother.where("created_at <= ?" ,Time.now.yesterday.end_of_day).count

    @entry_yesterday_count        = Entry.where(created_at: yesterday).count
    @entry_day_before_yesterday   = Entry.where(created_at: day_before_yesterday).count
    @entry_diff                   = @entry_day_before_yesterday - @entry_yesterday_count
    @entry_total                  = Entry.where("created_at <= ?" ,Time.now.yesterday.end_of_day).count

    @date = Time.now.yesterday.strftime('%Y年%m月%d日')

    mail(to: staff_mail_list,
         subject: "【まめぶろ】Daily スコアレポート #{@date}")
  end
end
