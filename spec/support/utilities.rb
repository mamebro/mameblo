include ApplicationHelper

def sign_in(brother)
  visit signin_path
  fill_in "session_name", with: brother.name
  fill_in "session_password", with: brother.password
  click_button "兄弟元気かな"
end

def sign_in_for_controller(brother)
  # For controller specs, set cookie directly
  cookies[:remember_token] = brother.remember_token
end

def signin_with_failed(brother)
  visit signin_path
  fill_in "session_name", with: brother.name + ":::"
  fill_in "session_password", with: brother.password + "::"
  click_button "兄弟元気かな"
  # cookies[:remember_token] = nil
end
