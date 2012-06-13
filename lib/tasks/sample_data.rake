namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entry
  end

  def make_users
    99.times do |n|
      name  = Faker::Name.name
      password  = "password"
      User.create!(name: name,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_entry
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.entry.create!(content: content) }
    end
  end
end
