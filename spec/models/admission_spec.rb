require 'rails_helper'

RSpec.describe Admission, type: :model do
  let(:veterinary) { create :veterinary }
  let(:veterinarian) { create :veterinarian, veterinaries: [veterinary] }

  it 'should create an Admission' do
    admission = Admission.create(
      veterinarian_id: veterinarian.id,
      veterinary_id: veterinary.id,
      petitioner_name: "#{veterinarian.full_name} (#{veterinary.name})",
      petitioner_phone: veterinarian.phone,
      petitioner_email: veterinarian.email,
      patient_name: 'Wanda',
      species: :canine,
      sex: :female,
      breed: 'Rottweiler',
      age: '3a1m',
      owner_name: 'Bibi',
      comments: 'Hello, do not forget this',
      exams: %w[Urea]
    )
    expect(admission.persisted?).to be_truthy
  end

  it 'should allow to create without veterinarian nor veterinary' do
    admission = Admission.create(
      petitioner_name: 'AAA',
      species: :canine,
      owner_name: 'BBB',
      exams: %w[Urea]
    )
    expect(admission.persisted?).to be_truthy
  end
end
