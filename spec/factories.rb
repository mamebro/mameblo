# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :user do
    name "shikakun"
    email "hogehoge@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :entry do
    title "テンション上がってきた"
    content "kunshika"
    user
  end
end
