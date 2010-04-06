Factory.sequence :email do |n|
  "one#{n}@yahoo.com"
end

Factory.sequence :login do |n|
  "login_name#{n}"
end

Factory.define :user do |u|
  u.first_name 'john'
  u.last_name 'doe'
  u.sequence(:login) {|n| "login#{n}"}
  u.password 'apassword'
  u.password_confirmation 'apassword'
  u.sequence(:email){|n| "one#{n}@yahoo.com"}
end