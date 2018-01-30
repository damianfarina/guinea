require 'rails_helper'

RSpec.describe 'admissions/index', type: :view do
  let(:veterinarian) { create :veterinarian }

  before(:each) do
    assign(:admissions, [
      create(:admission,
        veterinarian: veterinarian,
        petitioner_name: veterinarian.name,
        petitioner_phone: veterinarian.phone,
        petitioner_email: veterinarian.email,
        patient_name: 'Patient Name',
        species: :canine,
        sex: :male,
        breed: 'Caniche',
        exams: %w[Urea Creatinina]
      ),
      create(:admission,
        veterinarian: veterinarian,
        petitioner_name: veterinarian.name,
        petitioner_phone: veterinarian.phone,
        petitioner_email: veterinarian.email,
        patient_name: 'Patient Name',
        species: :feline,
        sex: :female,
        breed: 'Puma',
        exams: []
      )
    ])
  end

  it 'renders a list of admissions' do
    render
    assert_select 'tr>td', text: veterinarian.name, count: 2
    assert_select 'tr>td', text: 'Patient Name', count: 2
    assert_select 'tr>td', text: 'canino', count: 1
    assert_select 'tr>td', text: 'felino', count: 1
    assert_select 'tr>td', text: 'masculino', count: 1
    assert_select 'tr>td', text: 'femenino', count: 1
    assert_select 'tr>td', text: 'Caniche', count: 1
    assert_select 'tr>td', text: 'Puma', count: 1
    assert_select 'tr>td.exams-count', text: '2', count: 1
    assert_select 'tr>td.exams-count', text: '0', count: 1
  end
end
