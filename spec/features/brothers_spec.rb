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
      is_expected.to have_content('近況')
      is_expected.to have_content brother.name
      is_expected.to have_content @brother.name
    end

    scenario 'ブラザー名をクリックしてブラザー詳細に移動できること' do
      click_link @brother.name
      is_expected.to have_content @brother.name
      is_expected.to have_selector('#beBrother', 'ブラザーになる')
    end

    scenario '日記を投稿できること' do
      fill_in 'entry-form-title', with: '日記のタイトル'
      fill_in 'entry-form-content', with: 'こんにちは、本文です。'
      click_button '投稿'
      is_expected.to have_content 'ぶろぐ投稿できたね'
    end

    feature '設定ページ' do
      before do
        click_link '設定'
      end

      scenario 'パスワードを変更できること' do
        fill_in 'brother[present_password]', with: 'shikakun'
        fill_in 'brother[password]', with: 'password'
        fill_in 'brother[password_confirmation]', with: 'password'
        click_button 'パスワードの変更'
        is_expected.to have_content 'パスワード変更しました'
      end

      scenario '現在のパスワードを間違えた時はパスワード変更できない' do
        fill_in 'brother[present_password]', with: 'kunshika'
        fill_in 'brother[password]', with: 'password'
        fill_in 'brother[password_confirmation]', with: 'password'
        click_button 'パスワードの変更'
        is_expected.to have_content '!!! 現在のパスワードが間違ってます !!!'
      end

      scenario '確認用パスワードを間違えた時はパスワード変更できない' do
        fill_in 'brother[present_password]', with: 'shikakun'
        fill_in 'brother[password]', with: 'password'
        fill_in 'brother[password_confirmation]', with: 'passwooo'
        click_button 'パスワードの変更'
        is_expected.to have_content 'Password confirmationと確認の入力が一致しません'
      end

      scenario '現在のパスワードを間違えた時はメールアドレス変更できない' do
        fill_in 'brother[alter_email]', with: 'dev@mamebro.com'
        fill_in 'brother[current_password]', with: 'kunshika'
        click_button 'メールアドレスの変更'
        is_expected.to have_content '!!! パスワードが間違ってます !!!'
      end

      scenario 'メールアドレス変更のメールが送信されること' do
        fill_in 'brother[alter_email]', with: 'dev@mamebro.com'
        fill_in 'brother[current_password]', with: 'shikakun'
        click_button 'メールアドレスの変更'
        is_expected.to have_content '!!! 変更後のメールアドレスに確認メールを送信しました !!!'
      end
    end
  end
end
