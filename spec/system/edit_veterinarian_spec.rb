require 'rails_helper'

RSpec.describe 'editing a veterinarian', type: :system do
  let!(:veterinary1) { create :veterinary }
  let!(:veterinary2) { create :veterinary }
  let!(:veterinary3) { create :veterinary }
  let(:veterinarian) do
    create :veterinarian, veterinaries: [veterinary1, veterinary2]
  end

  before(:each) do
    visit veterinarian_path(veterinarian)
  end

  it 'should create a veterinarian' do
    expect(page).to have_content(veterinarian[:full_name])
    expect(page).to have_content(veterinarian[:phone])
    expect(page).to have_content(veterinarian[:email])
    expect(page).to have_content(veterinary1.name)
    expect(page).to have_content(veterinary2.name)

    click_on('actualizar')

    expect(current_path).to eq(edit_veterinarian_path(veterinarian))
    expect(page).to have_select('veterinarias', visible: false, selected: [
      veterinary1.name, veterinary2.name
    ])

    fill_in 'nombre', with: 'Albert'
    fill_in 'teléfono', with: '321 321 321'
    fill_in 'EMail', with: 'albert@email.com'
    unselect veterinary1.name, from: 'veterinarias'
    unselect veterinary2.name, from: 'veterinarias'
    select veterinary3.name, from: 'veterinarias'

    click_on('actualizar veterinario')

    expect(current_path).to eq(veterinarian_path(veterinarian))
    expect(page).to have_content('veterinario fue actualizado correctamente')
    expect(page).to have_content('Albert')
    expect(page).to have_content('321 321 321')
    expect(page).to have_content('albert@email.com')
    expect(page).to have_content(veterinary3.name)
    expect(page).not_to have_content(veterinary1.name)
    expect(page).not_to have_content(veterinary2.name)
  end
end
