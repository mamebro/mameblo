FactoryGirl.define do
  factory :brother do
    sequence(:name)  { |n| "shikakun#{n}" }
    sequence(:email) { |n| "shikakun#{n}@example.com" }
    password "shikakun"
    password_confirmation "shikakun"
    password_reset_token "1234mametest"
  end

  factory :entry do
    sequence(:title) { |n| "タイトル: テンションが#{n}上がってきた" }
    sequence(:content) { |n| "コンテンツ: 日記の本文だよー#{n}" }
    brother
  end
end
