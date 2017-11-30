require 'rails_helper'

RSpec.describe Admission, type: :model do
  let(:petitioner) do
    Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )
  end

  it 'should create an Admission' do
    admission = Admission.create(
      petitioner_name: petitioner.name,
      petitioner_id: petitioner.id,
      petitioner_type: petitioner.class.to_s,
      petitioner_phone: '261 666 5555',
      petitioner_email: 'montoto@elcachorro.com',
      patient_name: 'Wanda',
      species: 'canine',
      sex: 'female',
      breed: 'Rottweiler',
      months: '37',
      owner_name: 'Karina Yonson',
      comments: 'Hello, do not forget this'
    )
    expect(admission.persisted?).to be_truthy
  end
end
