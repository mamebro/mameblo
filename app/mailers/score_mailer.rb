# -*- coding: utf-8 -*-
class ScoreMailer < ActionMailer::Base
  def daily_report
    @date = Time.now.yesterday
    @score = ScoreCounter.new.count_by_day(@date)

    mail(to:      ["yuta.kurotaki@gmail.com"],
         # cc:      [""],
         subject: "【まめぶろ】Dailyスコアレポート #{@date.to_s}")
  end
end
