FactoryBot.define do
  factory :user do
    email { 'test@sample.com' }
    name { 'test太郎' }
    role { 1 }
    password { 'password' }
    password_confirmation { 'password' }
  end
end