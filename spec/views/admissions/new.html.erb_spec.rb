require 'rails_helper'

RSpec.describe 'admissions/new', type: :view do
  let(:veterinarian) { create :veterinarian }

  before(:each) do
    assign(:admission, Admission.new)
  end

  it 'renders new admission form' do
    render

    assert_select 'form[action=?][method=?]', admissions_path, 'post' do
      assert_select '.petitioner' do
        assert_select '*', 'solicitante'
        assert_select 'select[name=?]', 'admission[veterinarian_id]'
        assert_select 'select[name=?]', 'admission[veterinary_id]'
        assert_select 'input[name=?]', 'admission[petitioner_name]'
        assert_select 'input[name=?]', 'admission[petitioner_phone]'
        assert_select 'input[name=?]', 'admission[petitioner_email]'
      end

      assert_select '.patient' do
        assert_select '*', 'paciente'
        assert_select 'input[name=?]', 'admission[patient_name]'
        assert_select 'input[name=?]', 'admission[species]'
        assert_select 'input[name=?]', 'admission[sex]'
        assert_select 'input[name=?]', 'admission[breed]'
        assert_select 'input[name=?]', 'admission[age]'
        assert_select 'input[name=?]', 'admission[owner_name]'
      end

      assert_select '.others' do
        assert_select '*', 'otros'
        assert_select 'textarea[name=?]', 'admission[comments]'
      end

      assert_select '.exams' do
        assert_select '*', 'exámenes'
        assert_select 'input[name=?]', 'admission[exams][]'

        assert_select '.category:first' do
          assert_select 'label', 'Bioquímica'
          assert_select 'label', 'Amilasa'
          assert_select 'input[value=?]', 'Amilasa'
          assert_select 'label', 'Fósforo'
          assert_select 'input[value=?]', 'Fósforo'
        end
      end
    end
  end
end
