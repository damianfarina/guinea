require 'rails_helper'

RSpec.describe CreatesAdmission do
  let(:veterinary) { create :veterinary }
  let(:veterinarian) { create :veterinarian, veterinaries: [veterinary] }
  let(:creator) { CreatesAdmission.new(admission_params) }

  describe 'initialization' do
    let(:admission_params) do
      {
        veterinarian_id: veterinarian.id,
        veterinary_id: veterinary.id,
        petitioner_name: "#{veterinarian.full_name} (#{veterinary.name})",
        petitioner_phone: veterinarian.phone,
        petitioner_email: veterinarian.email,
        patient_name: 'Dalma',
        species: :canine,
        sex: :female,
        breed: 'German Shepherd',
        owner_name: 'Edward',
        age: '9a3m',
        comments: 'Lovely dog'
      }
    end

    it 'creates an admission' do
      admission = creator.build
      expect(admission.created_at.to_date).to eq(Date.current)
      expect(admission.age).to eq('9a3m')
      expect(admission.petitioner_name).to eq("#{veterinarian.full_name} (#{veterinary.name})")
    end
  end

  describe 'failure cases' do
    it 'should fail when trying to save an admission with no petitioner' do
      creator = CreatesAdmission.new(
        petitioner_name: '',
        petitioner_email: '',
        petitioner_phone: ''
      )
      creator.create
      expect(creator).not_to be_a_success
    end
  end
end
