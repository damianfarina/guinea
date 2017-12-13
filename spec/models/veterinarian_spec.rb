require 'rails_helper'

RSpec.describe Veterinarian, type: :model do
  let(:veterinarian) do
    Veterinarian.create!(
      full_name: 'Doc Enrique',
      phone: '261 669 1452',
      email: 'email@email.com'
    )
  end

  let(:veterinary) do
    Veterinary.create!(name: 'The Vet', phone: '261 491 7654')
  end

  before(:each) do
    veterinary.veterinarians = [veterinarian]
  end

  it 'should have associations with veterinarians' do
    expect(veterinarian.veterinaries.count).to eq(1)
  end

  it 'should not allow duplicated phones' do
    expect do
      Veterinarian.create!(full_name: 'Vet', phone: '261 669 1452')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not allow duplicated emails' do
    expect do
      Veterinarian.create!(full_name: 'Vet', email: 'email@email.com')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should require only a name' do
    Veterinarian.create!(full_name: 'Vet')
    vet = Veterinarian.create!(full_name: 'Vet')
    expect(vet).to be_persisted
    expect(Veterinarian.where(full_name: 'Vet').count).to be(2)
  end
end
