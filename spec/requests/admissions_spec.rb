require 'rails_helper'

RSpec.describe 'Admissions', type: :request do
  let!(:admission) do
    petitioner = Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )

    Admission.create(
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
  end

  describe 'GET /admissions' do
    it 'should return a list of admissions' do
      get admissions_path
      expect(response).to have_http_status(200)
    end
  end
end
