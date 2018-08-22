FactoryGirl.define do
  factory :survivor do
    name { "naiguel"}
    age { "28" }
    gender 'M'
    latitude { "123456" }
    longitude { "123456" }


    factory :survivor_one do
      name {  "Naiguel 01"}
      age { Faker::Number.number(2)}
      gender 'M'
      latitude {  Faker::Number.decimal(2, 6) }
      longitude { Faker::Number.decimal(2, 6) }
    end


    factory :survivor_two do
      name {  "Naiguel 02"}
      age { Faker::Number.number(2)}
      gender 'M'
      latitude {  Faker::Number.decimal(2, 6) }
      longitude { Faker::Number.decimal(2, 6) }
    end

  end
end
