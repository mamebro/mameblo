# -*- coding: utf-8 -*-
require 'spec_helper'
require 'rake'

describe "rake" do
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    load Rails.root + 'lib/tasks/batches/score_mailer/daily_report.rake'
    Rake::Task.define_task(:environment)
  end

  after do
    Timecop.return
  end

  describe "task batches:score_mailer:daily_report" do
    it "should have 'environment' as a prerequisite" do
      @rake['batches:score_mailer:daily_report'].prerequisites.should include("environment")
    end

    context '毎日 8:00am' do
      before do
        cron_time = Time.now.change({ hour: 8, min: 0, sec: 0 })
        Timecop.travel(cron_time)
        ActionMailer::Base.deliveries.clear
      end

      it 'レポートメールを送信すること' do
        expect {
          @rake['batches:score_mailer:daily_report'].invoke
        }.to change {
          ActionMailer::Base.deliveries.size
        }.by(1)
      end
    end
  end
end
