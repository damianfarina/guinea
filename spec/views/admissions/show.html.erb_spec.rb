require 'rails_helper'

RSpec.describe 'admissions/show', type: :view do
  let(:petitioner) do
    Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )
  end

  before(:each) do
    @admission = assign(:admission, Admission.create!(
      petitioner: petitioner,
      petitioner_name: petitioner.name,
      petitioner_type: petitioner.class.to_s,
      petitioner_phone: petitioner.phone,
      petitioner_email: petitioner.email,
      patient_name: 'Patient Name',
      species: :equine,
      sex: :female,
      breed: 'Black',
      months: 5,
      owner_name: 'Zorro',
      comments: 'Sargento'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Montoto \(Veterinary El Cachorro\)/)
    expect(rendered).to match(/#{petitioner.phone}/)
    expect(rendered).to match(/#{petitioner.email}/)
    expect(rendered).to match(/Patient Name/)
    expect(rendered).to match(/equine/)
    expect(rendered).to match(/female/)
    expect(rendered).to match(/Black/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Zorro/)
    expect(rendered).to match(/Sargento/)
  end
end
