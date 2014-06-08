FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "password"
    password_confirmation "password"

#    factory :admin do
#      admin true
#    end
  end

  factory :score do
    start_date  '2014-08-01'
    start_time  "09:00"
    team_top    "TEAM_A"
    team_bottom "TEAM_B"
    t1 "0"
    b1 "1"
    t2 "3"
    b2 "1"
    user
  end
end
