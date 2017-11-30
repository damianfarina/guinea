require 'rails_helper'

RSpec.describe "admissions/edit", type: :view do
  before(:each) do
    petitioner = Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )

    @admission = assign(:admission, Admission.create!(
      petitioner: petitioner,
      petitioner_name: 'Pedro',
      petitioner_type: 'Veterinarian',
      petitioner_phone: petitioner.phone,
      petitioner_email: petitioner.email,
      patient_name: 'Wanda',
      species: :canine,
      sex: :male,
      breed: 'Rottweiler',
      months: 14,
      owner_name: 'John'
    ))
  end

  it "renders the edit admission form" do
    render

    assert_select "form[action=?][method=?]", admission_path(@admission), "post" do

      assert_select "input[name=?]", "admission[petitioner_id]"

      assert_select "input[name=?]", "admission[petitioner_name]"

      assert_select "input[name=?]", "admission[petitioner_type]"

      assert_select "input[name=?]", "admission[petitioner_phone]"

      assert_select "input[name=?]", "admission[petitioner_email]"

      assert_select "input[name=?]", "admission[patient_name]"

      assert_select "input[name=?]", "admission[species]"

      assert_select "input[name=?]", "admission[sex]"

      assert_select "input[name=?]", "admission[breed]"

      assert_select "input[name=?]", "admission[months]"

      assert_select "input[name=?]", "admission[owner_name]"
    end
  end
end
