module Features
  module SessionHelpers
    def sign_in(brother)
      visit signin_path
      fill_in "session_name", with: brother.name
      fill_in "session_password", with: brother.password
      click_button "兄弟元気かな"
    end

    def signin_with_failed(brother)
      visit signin_path
      fill_in "session_name", with: brother.name + ":::"
      fill_in "session_password", with: brother.password + "::"
      click_button "兄弟元気かな"
    end
  end
end
