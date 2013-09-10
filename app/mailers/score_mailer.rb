class ScoreMailer < ActionMailer::Base
  default from: "score@mamebro.com"

  def daily
    staff_mail_list = YAML.load_file(Rails.root.to_s + '/config/staff_mail.yml')
    @date           = Time.now.yesterday.strftime('%Y年%m月%d日')
    @brother_total  = Brother.count
    @entry_total    = Entry.count
    @circus_total   = Circus.count
    mail(to: staff_mail_list,
         subject: "【まめぶろ】Daily スコアレポート #{@date}")
  end
end
