# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :circus, :class => 'Circus' do
    brother_id 1
    participation false
  end
end
