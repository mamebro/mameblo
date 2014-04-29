require 'spec_helper'

feature "Brother pages" do

  subject { page }

  feature "サインインした時" do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      @brother =  FactoryGirl.create(:brother)
      sign_in brother
      visit root_path
      visit brothers_path
    end

    scenario 'ブラザーの一覧が表示されること' do
      is_expected.to have_content('みんな')
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
