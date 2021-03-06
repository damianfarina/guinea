require 'rails_helper'

RSpec.describe 'admissions/show', type: :view do
  let(:veterinary) { create :veterinary }
  let(:veterinarian) { create :veterinarian, veterinaries: [veterinary] }
  let(:exams) { %w[Urea] }

  before(:each) do
    @admission = assign(:admission, Admission.create!(
      veterinarian: veterinarian,
      veterinary: veterinary,
      petitioner_name: veterinarian.name,
      petitioner_phone: veterinarian.phone,
      petitioner_email: veterinarian.email,
      patient_name: 'Patient Name',
      species: :equine,
      sex: :female,
      breed: 'Black',
      age: '5m',
      owner_name: 'Zorro',
      comments: 'Sargento',
      exams: exams
    ))
  end

  let(:exams) { %w[Urea Hepatozoon] }

  it 'renders admission attributes' do
    render
    expect(rendered).to have_selector('a', text: veterinarian.full_name)
    expect(rendered).to have_selector('a', text: veterinary.name)
    expect(rendered).to match(/#{veterinarian.phone}/)
    expect(rendered).to match(/#{veterinarian.email}/)
    expect(rendered).to match(/Patient Name/)
    expect(rendered).to match(/equino/)
    expect(rendered).to match(/femenino/)
    expect(rendered).to match(/Black/)
    expect(rendered).to match(/5m/)
    expect(rendered).to match(/Zorro/)
    expect(rendered).to match(/Sargento/)
    expect(rendered).to match(/Bioquímica/)
    expect(rendered).to match(/Urea/)
    expect(rendered).to match(/Hemoparásitos/)
    expect(rendered).to match(/Hepatozoon/)
  end
end
