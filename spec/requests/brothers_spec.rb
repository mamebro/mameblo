# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Brother pages" do

  subject { page }

  context "サインイン成功" do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      @brother =  FactoryGirl.create(:brother)
      sign_in brother
      visit root_path
      click_link 'ブラザーズ'
    end

    it 'ブラザーの一覧が表示されること' do
      should have_content('ブラザーズ')
      should have_content brother.name
      should have_content @brother.name
    end

    it 'ブラザー名をクリックしてブラザー詳細に移動できること' do
      click_link @brother.name
      should have_content @brother.name
      should have_selector('#beBrother', 'ブラザーになる')
    end
  end
end
