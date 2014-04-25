require 'spec_helper'

feature 'password resets' do

  subject { page }

  feature 'パスワード再設定画面へ移動' do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      visit root_path
      first(:link, 'サインイン').click
      click_link 'パスワードを忘れちゃった...!'
    end

    scenario 'メールアドレスを入力する画面が表示される' do
      is_expected.to have_content 'パスワードの再設定'
    end
  end
end
