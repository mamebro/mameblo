# -*- coding: utf-8 -*-
require 'spec_helper'

describe "mame blog(static_pages)" do

  subject { page }

  describe "サインインした時" do
    before{ visit root_path }

    describe "for signed-in brothers" do
      let(:brother) { FactoryGirl.create(:brother) }
      before do
        FactoryGirl.create(:entry, brother: brother)
        FactoryGirl.create(:entry, brother: brother)
        sign_in brother
        visit root_path
      end
      it { should have_content('shikakun') }
      it { should have_content('書く') }
      it { should have_content('ブラザー') }
      it { should have_content('設定') }

    end

    describe "サインイン失敗した時" do
      let(:brother) { FactoryGirl.create(:brother) }

      describe "brother failed login" do 
        before do
          signin_with_failed brother
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
