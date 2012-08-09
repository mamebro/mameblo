# -*- coding: utf-8 -*-
require 'spec_helper'

describe "mame blog(static_pages)" do

  subject { page }

  describe "Home" do
    before{ visit root_path }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:entry, user: user)
        FactoryGirl.create(:entry, user: user)
        sign_in user
        visit root_path
      end
      it { should have_content('shikakun') }
      it { should have_content('書く') }
      it { should have_content('ブラザー') }
      it { should have_content('設定') }

    end

    describe "user" do
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
        it { should_not have_content('書く') }
        it { should_not have_content('shikakun') }
        it { should_not have_content('ブラザーズ') }
        it { should have_content("あちゃー、もう一回お願いします!!!") }
      end
    end
  end
end
