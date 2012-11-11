# -*- coding: utf-8 -*-
namespace :batches do
  desc "TwitterAPI: 最新の最新のブラザーツイートを取得"
  task :twitter_api => :environment do
    brothers_tweet
  end

  def brothers_tweet
    begin
      @tweet = Twitter.user_timeline("mameblo").sample.text
    rescue
      @tweet = "まめまめまめまめまめぶろ♪"
    end
  end

end
