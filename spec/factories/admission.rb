FactoryBot.define do
  factory :admission do
    association :petitioner, factory: :veterinarian, strategy: :build
    petitioner_type { petitioner&.class.to_s }
    petitioner_id { petitioner&.id }
    petitioner_name { petitioner&.name }
    petitioner_phone { petitioner&.phone }
    petitioner_email { petitioner&.email }
    patient_name { Faker::Dog.name }
    species :canine
    sex { Faker::Dog.gender }
    breed { Faker::Dog.breed }
    months { rand(1..100) }
    owner_name { Faker::Name.name }
    comments { Faker::Dog.meme_phrase }
    completed false

    factory :admission_completed do
      completed true
    end
  end
end
