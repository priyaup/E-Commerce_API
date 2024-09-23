FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    role { "customer" }
    jti { SecureRandom.uuid }

    after(:create) do |user|
      create(:cart, user: user)
    end
  end
end