require 'rails_helper'

RSpec.describe "admissions/new", type: :view do
  before(:each) do
    petitioner = Veterinarian.create!(
      full_name: 'Montoto (Veterinary El Cachorro)',
      phone: '261 666 5555',
      email: 'montoto@elcachorro.com'
    )

    assign(:admission, Admission.new(
      petitioner: petitioner,
      petitioner_name: petitioner.name,
      petitioner_type: petitioner.class.to_s,
      petitioner_phone: petitioner.phone,
      petitioner_email: petitioner.email,
      patient_name: 'Coco',
      species: :canine,
      sex: :male,
      breed: 'Caniche',
      months: 1,
      owner_name: 'Ana',
      comments: 'A short comment'
    ))
  end

  it "renders new admission form" do
    render

    assert_select "form[action=?][method=?]", admissions_path, "post" do
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
      assert_select "textarea[name=?]", "admission[comments]"
    end
  end
end
