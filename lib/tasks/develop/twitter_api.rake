# -*- coding: utf-8 -*-
namespace :develop do
  desc "TwitterAPIから最新の最新のブラザーツイートを取得"
  task :brother_tweet => :environment do
    brothers_tweet
  end
end