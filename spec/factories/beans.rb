# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bean, :class => 'Beans' do
    type 1
    entry_id 1
    throw_brother_id 1
  end
end
