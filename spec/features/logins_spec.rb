require 'spec_helper'

feature "Logins" do

  subject { page }

  feature "サインインしていない時" do
    scenario "メニューからログイン画面へ移動してサインインできること" do
      brother = create(:brother)
      visit root_path
      click_link 'サインイン'
      fill_in "session_name", with: brother.name
      fill_in "session_password", with: brother.password
      click_button "兄弟元気かな"
      is_expected.to have_content "!!!!!!!! ブラザーよ !!!!!!!!"
    end

    scenario "メニューから新規登録画面へ移動して新規登録できること" do
      visit root_path
      click_link 'はじめる'
      fill_in "brother_name", with: 'chailatte'
      fill_in "brother_email", with: 'chailatte@example.com'
      fill_in "brother_password", with: 'password'
      fill_in "brother_password_confirmation", with: 'password'
      click_button "ブラザーになる!! (無料)"
      is_expected.to have_content "!!! まめぶろにようこそ !!!"
    end
  end
end
