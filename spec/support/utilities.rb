include ApplicationHelper

def sign_in(user)
  visit root_path
  fill_in "session_name", with: user.name
  fill_in "session_password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def signin_with_failed(user)
  visit root_path
  fill_in "session_name", with: user.name + "1221"
  fill_in "session_password", with: user.password + "www"
  click_button "Sign in"
  cookies[:remember_token] = nil
end
