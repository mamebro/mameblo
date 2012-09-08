namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_brothers
    make_entry
  end

  def make_brothers
    99.times do |n|
      name  = Faker::Name.name
      password  = "password"
      Brother.create!(name: name,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_entry
    brothers = Brother.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      brothers.each { |brother| brother.entry.create!(content: content) }
    end
  end
end
