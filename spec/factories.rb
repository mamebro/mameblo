# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :brother do
    sequence(:name)  { |n| "shikakun#{n}" }
    sequence(:email) { |n| "shikakun#{n}@example.com" }
    password "shikakun"
    password_confirmation "shikakun"
  end

  factory :entry do
    sequence(:title) { |n| "タイトル: テンションが#{n}上がってきた" }
    sequence(:content) { |n| "コンテンツ: 日記の本文だよー#{n}" }
    brother
  end
end
