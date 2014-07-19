require 'spec_helper'

feature "settings" do

  subject { page }

  feature '設定ページ' do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      @brother =  FactoryGirl.create(:brother)
      sign_in brother
      visit root_path
      visit settings_path
    end

    feature 'パスワードの変更' do
      before do
        click_link 'パスワードの変更'
      end

      scenario 'パスワードを変更できること' do
        fill_in 'brother[present_password]', with: 'shikakun'
        fill_in 'brother[password]', with: 'password'
        fill_in 'brother[password_confirmation]', with: 'password'
        click_button '変更する'
        is_expected.to have_content 'パスワード変更しました'
      end

      scenario '現在のパスワードを間違えた時はパスワード変更できない' do
        fill_in 'brother[present_password]', with: 'kunshika'
        fill_in 'brother[password]', with: 'password'
        fill_in 'brother[password_confirmation]', with: 'password'
        click_button '変更する'
        is_expected.to have_content '!!! 現在のパスワードが間違っています !!!'
      end

      scenario '確認用パスワードを間違えた時はパスワード変更できない' do
        fill_in 'brother[present_password]', with: 'shikakun'
        fill_in 'brother[password]', with: 'password'
        fill_in 'brother[password_confirmation]', with: 'passwooo'
        click_button '変更する'
        is_expected.to have_content '!!! 新しいパスワードが間違っています !!!'
      end
    end

    feature 'メールアドレスの変更' do
      before do
        click_link 'メールアドレスの変更'
      end

      scenario '現在のパスワードを間違えた時はメールアドレス変更できない' do
        fill_in 'brother[alter_email]', with: 'dev@mamebro.com'
        fill_in 'brother[current_password]', with: 'kunshika'
        click_button '変更する'
        is_expected.to have_content '!!! パスワードが間違っています !!!'
      end

      scenario 'メールアドレスの形式が間違っていたら変更できないこと' do
        fill_in 'brother[alter_email]', with: 'mamebrocom'
        fill_in 'brother[current_password]', with: 'shikakun'
        click_button '変更する'
        is_expected.to have_content '!!! メールアドレスの形式が間違っています !!!'
      end

      scenario 'メールアドレス変更のメールが送信されること' do
        fill_in 'brother[alter_email]', with: 'dev@mamebro.com'
        fill_in 'brother[current_password]', with: 'shikakun'
        click_button '変更する'
        is_expected.to have_content '!!! 変更後のメールアドレスに確認メールを送信しました !!!'
      end
    end
  end
end
