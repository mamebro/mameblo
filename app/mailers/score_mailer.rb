class ScoreMailer < ActionMailer::Base
  default from: "score@mamebro.com"

  def daily
    @date          = Time.now.yesterday.strftime('%Y年%m月%d日')
    @brother_total = Brother.count
    @entry_total   = Entry.count
    @circus_total  = Circus.count
    mail(to:      ["yuta.kurotaki@gmail.com", "k@u-n.jp"],
         # cc:      [""],
         subject: "【まめぶろ】Daily スコアレポート #{@date}")
  end
end
