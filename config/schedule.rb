# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# 出力先のログファイルの指定
set :output, 'log/cron.log'

# ジョブの実行環境の指定
set :environment, :production

# Dailyでスコアメールを送信する
# ブラザー数, エントリー数, サーカスみたいね数
every 1.day, at: '7:00am' do
  runner 'ScoreMailer.daily.deliver'
end

# mysqldumpを実行してS3に保存
every 1.days, :at=>'05:00' do
  rake 'db:backup'
end
