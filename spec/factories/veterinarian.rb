require 'mail'

FactoryBot.define do
  factory :veterinarian do
    full_name { Faker::Name.name }
    email do
      if veterinaries&.any?
        "#{Faker::Internet.user_name(full_name, %w[])}@#{Mail::Address.new(veterinaries.first.email).domain}"
      else
        Faker::Internet.email(full_name)
      end
    end
    phone { Faker::PhoneNumber.cell_phone }
  end
end
