require 'rails_helper'

RSpec.describe 'adding a veterinarian', type: :system do
  let(:veterinarian_attributes) { attributes_for :veterinarian }
  let!(:veterinary1) { create :veterinary }
  let!(:veterinary2) { create :veterinary }
  let!(:veterinary3) { create :veterinary }

  it 'should create a veterinarian' do
    visit new_veterinarian_path

    fill_in 'nombre', with: veterinarian_attributes[:full_name]
    fill_in 'teléfono', with: veterinarian_attributes[:phone]
    fill_in 'EMail', with: veterinarian_attributes[:email]
    select veterinary1.name, from: 'veterinarias'

    click_on('guardar veterinario')

    expect(page).to have_content('veterinario fue guardado correctamente')
    expect(page).to have_content(veterinarian_attributes[:full_name])
    expect(page).to have_content(veterinarian_attributes[:phone])
    expect(page).to have_content(veterinarian_attributes[:email])
    expect(page).to have_content(veterinary1.name)

    expect(page).not_to have_content(veterinary2.name)
    expect(page).not_to have_content(veterinary3.name)
  end
end
