FactoryBot.define do
  factory :veterinary do
    name { Faker::Company.name }
    email { "contact@#{Faker::Internet.user_name(name, %w[])}.com" }
    phone { Faker::PhoneNumber.phone_number }

    factory :veterinary_with_veterinarians do
      transient do
        veterinarians_count 5
      end

      after(:create) do |veterinary, evaluator|
        create_list :veterinarian, evaluator.veterinarians_count, veterinaries: [veterinary]
      end
    end
  end
end
