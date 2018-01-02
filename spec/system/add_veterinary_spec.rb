require 'rails_helper'

RSpec.describe 'adding a veterinary', type: :system do
  let(:veterinary_attributes) { attributes_for :veterinary }
  let!(:veterinarian1) { create :veterinarian }
  let!(:veterinarian2) { create :veterinarian }
  let!(:veterinarian3) { create :veterinarian }

  it 'should create a veterinary' do
    visit new_veterinary_path

    fill_in 'nombre', with: veterinary_attributes[:name]
    fill_in 'teléfono', with: veterinary_attributes[:phone]
    fill_in 'EMail', with: veterinary_attributes[:email]
    select veterinarian1.full_name, from: 'veterinarios'

    click_on('guardar veterinaria')

    expect(page).to have_content('veterinaria fue guardado correctamente')
    expect(page).to have_content(veterinary_attributes[:name])
    expect(page).to have_content(veterinary_attributes[:phone])
    expect(page).to have_content(veterinary_attributes[:email])
    expect(page).to have_content(veterinarian1.full_name)

    expect(page).not_to have_content(veterinarian2.full_name)
    expect(page).not_to have_content(veterinarian3.full_name)
  end
end
