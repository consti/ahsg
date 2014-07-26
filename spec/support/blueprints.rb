require 'machinist/active_record'

Location.blueprint do
  place_id { Faker::Bitcoin.address }
  latitude { Faker::Address.latitude }
  longitude { Faker::Address.longitude }
  country { Faker::Address.country }
  city { Faker::Address.city }
  name { object.city + ' ' + object.country }
end

User.blueprint do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  school_year_end { Date.today - rand(1..10).years }
  school_year_begin { object.school_year_end - rand(1..10).years }
  location
end
