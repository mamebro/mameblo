# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :brother do
    sequence(:name)  { |n| "shikakun #{n}" }
    sequence(:email) { |n| "shika_#{n}@example.com" }
    password "shikakun"
    password_confirmation "shikakun"
  end

  factory :entry do
    sequence(:title) { |n| "テンションが#{n}上がってきた" }
    sequence(:content) { |n| "kunshika #{n}" }
    brother
  end
end
