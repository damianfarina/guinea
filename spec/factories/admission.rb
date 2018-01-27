FactoryBot.define do
  factory :admission do
    petitioner_name { veterinarian&.full_name || veterinary&.name || Faker::Name.name }
    petitioner_phone { veterinarian&.phone || veterinary&.phone || Faker::PhoneNumber.cell_phone }
    petitioner_email { veterinarian&.email || veterinary&.email || Faker::Internet.email(petitioner_name) }
    patient_name { Faker::Dog.name }
    species :canine
    sex { Faker::Dog.gender }
    breed { Faker::Dog.breed }
    age { "#{rand(1..14)}a#{rand(1..12)}m" }
    owner_name { Faker::Name.name }
    comments { Faker::Dog.meme_phrase }
    completed false

    factory :admission_completed do
      completed true
    end
  end
end
