FactoryBot.define do
  factory :score do
    score {Faker::Number.number(digits: 2)}
    time {Faker::Date.forward(days: 23)}
    player
  end
end
