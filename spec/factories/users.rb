FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
#    after(:build) { |u| u.password_confirmation = u.password = '123' }
  end
end
