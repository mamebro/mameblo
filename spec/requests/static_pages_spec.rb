# -*- coding: utf-8 -*-
require 'spec_helper'

describe "mame blog(static_pages)" do

  subject { page }

  describe "Home" do
    before{ visit root_path }

    it { should have_selector 'h1',  text: "mameblog" }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:entry, user: user, content: "日記をかくよ、楽しいな")
        FactoryGirl.create(:entry, user: user, content: "メロンパン食べた！")
        sign_in user
        visit root_path
      end
    end

    describe " user" do
      describe "login&signin do not appear for signed-in users" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          sign_in user
          visit root_path
        end
        it { should have_selector('href',    text: 'Sign in') }
        it { should have_selector('href',    text: 'Join "mameblog"') }
      end
    end
  end
end
