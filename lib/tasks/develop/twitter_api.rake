# -*- coding: utf-8 -*-
namespace :develop do
  desc "TwitterAPIから最新の最新のブラザーツイートを取得"
  task :brother_tweet => :environment do
    class StaticPagesController < ApplicationController
      def get_brother_tweet
        begin
          @res = Twitter.user_timeline("mameblo", {"count" => 1})
          @res
        rescue
          @res = ["!!! ブラザーになろうぜ !!!"]
          @res
        end
      end
    end
  end
end
