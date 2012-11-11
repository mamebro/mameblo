# -*- coding: utf-8 -*-

namespace :batches do
  namespace :score_mailer do
    desc 'レポートメールを送信'
    task :daily_report => :environment do
      ScoreMailer.daily_report.deliver
    end
  end
end
