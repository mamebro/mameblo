# -*- coding: utf-8 -*-
include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "session_name", with: user.name
  fill_in "session_password", with: user.password
  click_button "マイブラザー元気かな"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def signin_with_failed(user)
  visit signin_path
  fill_in "session_name", with: user.name + ":::"
  fill_in "session_password", with: user.password + "::"
  click_button "マイブラザー元気かな"
  cookies[:remember_token] = nil
end
