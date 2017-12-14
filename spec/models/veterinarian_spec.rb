require 'rails_helper'

RSpec.describe Veterinarian, type: :model do
  let(:veterinarian) { create :veterinarian }
  let(:veterinary) { create :veterinary }

  before(:each) do
    veterinary.veterinarians = [veterinarian]
  end

  it 'should have associations with veterinarians' do
    expect(veterinarian.veterinaries.count).to eq(1)
  end

  it 'should not allow duplicated phones' do
    expect do
      Veterinarian.create!(full_name: 'Vet', phone: veterinarian.phone)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should not allow duplicated emails' do
    expect do
      Veterinarian.create!(full_name: 'Vet', email: veterinarian.email)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'should only require full_name' do
    expect do
      create :veterinarian, full_name: 'Vet', email: nil, phone: nil
    end.to change { Veterinarian.where(full_name: 'Vet').count }.by(1)
    expect do
      create :veterinarian, full_name: 'Vet', email: nil, phone: nil
    end.to change { Veterinarian.where(full_name: 'Vet').count }.by(1)
  end
end
