# -*- coding: utf-8 -*-
require 'spec_helper'

describe "mame blog(static_pages)" do

  subject { page }

  describe "Home" do
    before{ visit root_path }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:entry, user: user, content: "日記をかくよ、楽しいな")
        FactoryGirl.create(:entry, user: user, content: "メロンパン食べた！")
        sign_in user
        visit root_path
      end
      it { should have_content('日記をかくよ、楽しいな') }
      it { should have_content('メロンパン食べた！') }
    end

    describe " user" do
      let(:user) { FactoryGirl.create(:user) }

      describe "login&signin do not appear for signed-in users" do
        before do
          sign_in user
          visit root_path
        end
        it { should have_content('Write New Entry') }
        it { should have_content('Sign out') }
      end

      describe "user failed login" do 
        before do
          signin_with_failed user
          visit root_path
        end
        it { should_not have_content('Write New Entry') }
        it { should have_content("Sign in") }
      end
    end
  end
end
