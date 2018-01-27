require 'rails_helper'

RSpec.describe AdmissionHelper, type: :helper do
  let(:veterinarian) { create(:veterinarian) }
  let(:veterinary) { create(:veterinary) }
  let(:admission) { create :admission }
  let(:result) { admission_petitioner_link(admission, class: 'my-class') }

  context 'admission has a veterinarian' do
    let(:admission) { create :admission, veterinarian: veterinarian }

    it 'should generate a link to veterinarian' do
      expect(result).to include(admission.petitioner_name)
      expect(result).to include(veterinarian_path(veterinarian))
      expect(result).to have_selector('a.my-class')
    end
  end

  context 'admission has a veterinary' do
    let(:admission) { create :admission, veterinary: veterinary }

    it 'should generate a link to veterinary' do
      expect(result).to include(admission.petitioner_name)
      expect(result).to include(veterinary_path(veterinary))
      expect(result).to have_selector('a.my-class')
    end
  end

  context 'admission is missing veterinarian and veterinary' do
    it 'should generate a label' do
      expect(result).to include(admission.petitioner_name)
      expect(result).to have_selector('span.my-class')
    end
  end
end
