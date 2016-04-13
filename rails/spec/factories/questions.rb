FactoryGirl.define do
  factory :question do
    question { Faker::Lorem.sentence }
    answer   { Faker::Lorem.word }
  end
end
