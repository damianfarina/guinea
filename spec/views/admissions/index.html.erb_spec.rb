require 'rails_helper'

RSpec.describe 'admissions/index', type: :view do
  let!(:veterinary) { create :veterinary }
  let(:veterinarian) { create :veterinarian, veterinaries: [veterinary] }
  let(:admission1) do
    create(:admission,
      veterinarian: veterinarian,
      veterinary: veterinary,
      petitioner_name: veterinarian.name,
      petitioner_phone: veterinarian.phone,
      petitioner_email: veterinarian.email,
      patient_name: 'Patient Name',
      species: :canine,
      sex: :male,
      breed: 'Caniche',
      owner_name: 'Damian',
      exams: %w[Urea Creatinina],
      comments: 'Roads? Where we\'re going, we don\'t need roads. Silence, Earthling. My name is Darth Vader. I am an extraterrestrial from the planet Vulcan!'
    )
  end
  let(:admission2) do
    create(:admission,
      veterinarian: veterinarian,
      veterinary: veterinary,
      petitioner_name: veterinarian.name,
      petitioner_phone: veterinarian.phone,
      petitioner_email: veterinarian.email,
      patient_name: 'Patient Name',
      species: :feline,
      sex: :female,
      breed: 'Puma',
      exams: %w[Urea]
    )
  end

  before(:each) do
    assign(:admissions, [admission1, admission2])
  end

  it 'renders a list of admissions' do
    render
    assert_select '.admission', count: 2
    assert_select '.admissions' do
      assert_select '.admission:first' do
        assert_select "a.show[href='#{admission_path(admission1)}']", count: 1
        assert_select '.petitioner', text: veterinarian.full_name, count: 1
        assert_select '.patient', text: admission1.patient_name, count: 1
        assert_select '.species', text: 'canino', count: 1
        assert_select '.breed', text: admission1.breed, count: 1
        assert_select '.owner', text: 'Damian', count: 1
        assert_select '.comments', text: admission1.comments, count: 1
        assert_select '.exams-count', text: "#{admission1.exams.count} exámenes", count: 1
      end
    end
  end
end
