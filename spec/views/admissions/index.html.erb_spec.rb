require 'rails_helper'

RSpec.describe "admissions/index", type: :view do
  let(:petitioner) do
    Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )
  end

  before(:each) do
    assign(:admissions, [
      Admission.create!(
        petitioner: petitioner,
        petitioner_name: petitioner.name,
        petitioner_type: petitioner.class.to_s,
        patient_name: "Patient Name",
        species: :canine,
        sex: :male,
        breed: "Caniche"
      ),
      Admission.create!(
        petitioner: petitioner,
        petitioner_name: petitioner.name,
        petitioner_type: petitioner.class.to_s,
        patient_name: "Patient Name",
        species: :feline,
        sex: :female,
        breed: "Puma"
      )
    ])
  end

  it "renders a list of admissions" do
    render
    assert_select "tr>td", :text => petitioner.name, :count => 2
    assert_select "tr>td", :text => 'Patient Name', :count => 2
    assert_select "tr>td", :text => 'canino', :count => 1
    assert_select "tr>td", :text => 'felino', :count => 1
    assert_select "tr>td", :text => 'masculino', :count => 1
    assert_select "tr>td", :text => 'femenino', :count => 1
    assert_select "tr>td", :text => 'Caniche', :count => 1
    assert_select "tr>td", :text => 'Puma', :count => 1
  end
end
