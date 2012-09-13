# -*- coding: utf-8 -*-
include ApplicationHelper

def sign_in(brother)
  visit signin_path
  fill_in "session_name", with: brother.name
  fill_in "session_password", with: brother.password
  click_button "マイブラザー元気かな"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = brother.remember_token
end

def signin_with_failed(brother)
  visit signin_path
  fill_in "session_name", with: brother.name + ":::"
  fill_in "session_password", with: brother.password + "::"
  click_button "マイブラザー元気かな"
  cookies[:remember_token] = nil
end
