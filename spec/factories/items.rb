numbers = [0,1,1,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3]

FactoryBot.define do
  factory :item do
    name { Faker::Games::Zelda.item }
    description { Faker::Books::Lovecraft.sentence }
    unit_price { Faker::Number.decimal(l_digits: numbers.sample, r_digits: 2) }
    merchant
  end
end
