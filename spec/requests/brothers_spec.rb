require 'spec_helper'

describe "Brother pages" do

  subject { page }

  context "サインイン成功" do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      @brother =  FactoryGirl.create(:brother)
      sign_in brother
      visit root_path
      visit brothers_path
    end

    it 'ブラザーの一覧が表示されること' do
      is_expected.to have_content('ブラザーズ')
      is_expected.to have_content brother.name
      is_expected.to have_content @brother.name
    end

    it 'ブラザー名をクリックしてブラザー詳細に移動できること' do
      click_link @brother.name
      is_expected.to have_content @brother.name
      is_expected.to have_selector('#beBrother', 'ブラザーになる')
    end
  end
end
