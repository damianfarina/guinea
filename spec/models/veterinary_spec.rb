require 'rails_helper'

RSpec.describe Veterinary, type: :model do
  let(:veterinarian) do
    Veterinarian.create!(
      name: 'Doc Enrique',
      phone: '261 669 1452'
    )
  end

  let(:veterinary) do
    Veterinary.create!(
      name: 'The Vet',
      phone: '261 491 7654',
      email: 'email@email.com'
    )
  end

  before(:each) do
    veterinarian.veterinaries = [veterinary]
  end

  it 'should have associations with veterinarians' do
    expect(veterinary.veterinarians.count).to eq(1)
  end

  it 'should not allow duplicated phones' do
    expect do
      Veterinary.create!(name: 'Vet', phone: '261 491 7654')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not allow duplicated emails' do
    expect do
      Veterinary.create!(name: 'Vet', email: 'email@email.com')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should only require a name' do
    expect do
      create :veterinary, name: 'Vet', email: nil, phone: nil
    end.to change { Veterinary.where(name: 'Vet').count }.by(1)
    expect do
      create :veterinary, name: 'Vet', email: nil, phone: nil
    end.to change { Veterinary.where(name: 'Vet').count }.by(1)
  end
end
