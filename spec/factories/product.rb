FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { 10 }
    description { 'Farmgirl Product' }
  end
end
