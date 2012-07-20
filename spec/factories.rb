FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "person#{n}" }
    email "hogehoge#{n}@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :entry do
    content "kunshika"
    user
  end
end
