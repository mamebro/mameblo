FactoryBot.define do
  factory :entry_has_hashtag do
    entry nil
    hashtag nil
  end

  factory :hashtag do
    name "MyString"
  end

  factory :brother do
    sequence(:name)  { |n| "shikakun#{n}" }
    sequence(:email) { |n| "shikakun#{n}@example.com" }
    password "shikakun"
    password_confirmation "shikakun"
    password_reset_token SecureRandom.urlsafe_base64
  end

  factory :entry do
    sequence(:title) { |n| "タイトル: テンションが#{n}上がってきた" }
    sequence(:content) { |n| "コンテンツ: 日記の本文だよー#{n}" }
    brother
  end
end
