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
        petitioner_phone: petitioner.phone,
        petitioner_email: petitioner.email,
        patient_name: "Patient Name",
        species: :canine,
        sex: :male,
        breed: "Caniche",
        months: 5,
        owner_name: "Mabel"
      ),
      Admission.create!(
        petitioner: petitioner,
        petitioner_name: petitioner.name,
        petitioner_type: petitioner.class.to_s,
        petitioner_phone: petitioner.phone,
        petitioner_email: petitioner.email,
        patient_name: "Patient Name",
        species: :feline,
        sex: :female,
        breed: "Puma",
        months: 15,
        owner_name: "Jonatan"
      )
    ])
  end

  it "renders a list of admissions" do
    render
    assert_select "tr>td", :text => petitioner.name, :count => 2
    assert_select "tr>td", :text => petitioner.phone, :count => 2
    assert_select "tr>td", :text => petitioner.email, :count => 2
    assert_select "tr>td", :text => 'Patient Name'.to_s, :count => 2
    assert_select "tr>td", :text => 'canine', :count => 1
    assert_select "tr>td", :text => 'feline', :count => 1
    assert_select "tr>td", :text => 'male', :count => 1
    assert_select "tr>td", :text => 'female', :count => 1
    assert_select "tr>td", :text => 'Caniche'.to_s, :count => 1
    assert_select "tr>td", :text => 'Puma'.to_s, :count => 1
    assert_select "tr>td", :text => 5.to_s, :count => 1
    assert_select "tr>td", :text => 15.to_s, :count => 1
    assert_select "tr>td", :text => 'Mabel'.to_s, :count => 1
    assert_select "tr>td", :text => 'Jonatan'.to_s, :count => 1
  end
end
