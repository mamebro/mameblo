# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "shikakun #{n}" }
    sequence(:email) { |n| "shika_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :entry do
    title "テンション上がってきた"
    content "kunshika"
    user
  end
end
