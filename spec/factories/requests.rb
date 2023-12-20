FactoryBot.define do
  factory :request do
    title { 'Sample Request' }
    isbn { '123456789' }
    author { ['Author 1', 'Author 2'] }
    # 他の属性や関連を追加
    association :user
    trait :user do
      association :user
    end
  end
end