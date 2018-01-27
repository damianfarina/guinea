require 'rails_helper'

RSpec.describe 'admissions/new', type: :view do
  let(:veterinarian) { create :veterinarian }

  before(:each) do
    assign(:admission, Admission.new(
      veterinarian: veterinarian,
      petitioner_name: veterinarian.name,
      petitioner_phone: veterinarian.phone,
      petitioner_email: veterinarian.email,
      patient_name: 'Coco',
      species: :canine,
      sex: :male,
      breed: 'Caniche',
      age: '1m',
      owner_name: 'Ana',
      comments: 'A short comment'
    ))
  end

  it 'renders new admission form' do
    render

    assert_select 'form[action=?][method=?]', admissions_path, 'post' do
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
    end
  end
end
