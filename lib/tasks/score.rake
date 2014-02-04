namespace :score do
  desc "Daily スコアレポートをikachanで通知します"
  task :daily => :environment do
    include Ikachan
    yesterday            = Time.now.yesterday.all_day
    day_before_yesterday = Time.now.yesterday.yesterday.all_day

    brother_yesterday            = Brother.where(created_at: yesterday)
    brother_day_before_yesterday = Brother.where(created_at: day_before_yesterday)
    brother_diff                 = brother_yesterday.count - brother_day_before_yesterday.count
    brother_total                = Brother.where("created_at <= ?" ,Time.now.yesterday.end_of_day).count

    entry_yesterday              = Entry.where(created_at: yesterday)
    entry_day_before_yesterday   = Entry.where(created_at: day_before_yesterday)
    entry_diff                   = entry_yesterday.count - entry_day_before_yesterday.count
    entry_total                  = Entry.where("created_at <= ?" ,Time.now.yesterday.end_of_day).count

    beans_yesterday              = Bean.where(created_at: yesterday)
    beans_day_before_yesterday   = Bean.where(created_at: day_before_yesterday)
    beans_diff                   = beans_yesterday.count - beans_day_before_yesterday.count
    beans_total                  = Bean.count
    date = Time.now.yesterday.strftime('%Y年%m月%d日')

    ikachan_post "!!! 【まめぶろ】Daily スコアレポート #{date} !!!"
    ikachan_post "---------------------------------------------------"
    ikachan_post "ブラザー数合計: #{brother_total}"
    ikachan_post "昨日兄弟になったブラザー: #{brother_yesterday.count} 前日比(#{brother_diff})"
    ikachan_post "エントリー数合計: #{entry_total}"
    ikachan_post "昨日のエントリー数: #{entry_yesterday.count} 前日比(#{entry_diff})"
    ikachan_post "投げられた豆の数合計: #{beans_total}"
    ikachan_post "昨日投げられた豆の数: #{beans_yesterday.count} 前日比(#{beans_diff})"
    ikachan_post "---------------------------------------------------"
  end
end
