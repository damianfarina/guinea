require 'rails_helper'

RSpec.describe 'admissions/edit', type: :view do
  let(:veterinarian) { create :veterinarian }

  before(:each) do
    @admission = assign(:admission, Admission.create!(
      veterinarian: veterinarian,
      petitioner_name: 'Pedro',
      petitioner_phone: veterinarian.phone,
      petitioner_email: veterinarian.email,
      patient_name: 'Wanda',
      species: :canine,
      sex: :male,
      breed: 'Rottweiler',
      age: '1a2m',
      owner_name: 'John',
      exams: %w[Urea]
    ))
  end

  it 'renders the edit admission form' do
    render

    assert_select 'form[action=?][method=?]', admission_path(@admission), 'post' do
      assert_select 'select[name=?]', 'admission[veterinarian_id]'
      assert_select 'select[name=?]', 'admission[veterinary_id]'
      assert_select 'input[name=?]', 'admission[petitioner_name]'
      assert_select 'input[name=?]', 'admission[petitioner_phone]'
      assert_select 'input[name=?]', 'admission[petitioner_email]'
      assert_select 'input[name=?]', 'admission[patient_name]'
      assert_select 'input[name=?]', 'admission[species]'
      assert_select 'input[name=?]', 'admission[sex]'
      assert_select 'input[name=?]', 'admission[breed]'
      assert_select 'input[name=?]', 'admission[age]'
      assert_select 'input[name=?]', 'admission[owner_name]'
      assert_select 'textarea[name=?]', 'admission[comments]'
      assert_select 'input[name=?]', 'admission[exams][]'
    end
  end
end
