require 'spec_helper'

describe "Vote pages" do

  subject { page }

  context "サインイン成功" do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      @brother =  FactoryGirl.create(:brother)
      sign_in brother
      visit root_path
      click_link '選挙'
    end

    it '開票速報が表示されること' do
      should have_content('開票速報')
      should have_content('投票率')
    end
  end
end
