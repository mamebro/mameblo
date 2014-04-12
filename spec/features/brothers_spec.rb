require 'spec_helper'

feature "Brother pages" do

  subject { page }

  feature "サインインした時" do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      @brother =  FactoryGirl.create(:brother)
      visit signin_path
      fill_in "session_name", with: brother.name
      fill_in "session_password", with: brother.password
      click_button "兄弟元気かな"
      visit root_path
      visit brothers_path
    end

    scenario 'ブラザーの一覧が表示されること' do
      is_expected.to have_content('ブラザーズ')
      is_expected.to have_content brother.name
      is_expected.to have_content @brother.name
    end

    scenario 'ブラザー名をクリックしてブラザー詳細に移動できること' do
      click_link @brother.name
      is_expected.to have_content @brother.name
      is_expected.to have_selector('#beBrother', 'ブラザーになる')
    end
  end
end
