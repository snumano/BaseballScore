require "date"

today = Date.today

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.jp",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    50.times do
      start_date = today + Faker::Number.number(3).to_i
      team_top = Faker::Name.last_name[0,10]
      team_bottom = Faker::Name.last_name[0,10]
      t1 = Faker::Number.digit
      b1 = Faker::Number.digit
      t2 = Faker::Number.digit
      b2 = Faker::Number.digit
      t3 = Faker::Number.digit
      b3 = Faker::Number.digit
      users.each { |user| user.scores.create!(start_date: start_date, team_top: team_top, team_bottom: team_bottom, t1: t1, b1: b1, t2: t2, b2: b2, t3: t3, b3: b3) }
    end
  end
end
