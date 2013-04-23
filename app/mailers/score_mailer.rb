class ScoreMailer < ActionMailer::Base
  default from: "example@mameblo.com"

  def daily
    @date          = Time.now.yesterday.strftime('%Y年%m月%d日')
    @brother_total = Brother.count
    @entry_total   = Entry.count
    @circus_total  = Circus.count
    mail(to:      ["yuta.kurotaki@gmail.com"],
         # cc:      [""],
         subject: "【まめぶろ】Dailyスコアレポート #{@date}")
  end
end
