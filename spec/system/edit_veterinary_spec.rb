require 'rails_helper'

RSpec.describe 'editing a veterinary', type: :system do
  let!(:veterinarian1) { create :veterinarian }
  let!(:veterinarian2) { create :veterinarian }
  let!(:veterinarian3) { create :veterinarian }
  let(:veterinary) do
    create :veterinary, veterinarians: [veterinarian1, veterinarian2]
  end

  before(:each) do
    visit veterinary_path(veterinary)
  end

  it 'should create a veterinary' do
    expect(page).to have_content(veterinary[:name])
    expect(page).to have_content(veterinary[:phone])
    expect(page).to have_content(veterinary[:email])
    expect(page).to have_content(veterinarian1.full_name)
    expect(page).to have_content(veterinarian2.full_name)

    click_on('Edit')

    expect(current_path).to eq(edit_veterinary_path(veterinary))
    expect(page).to have_select('Veterinarians', visible: false, selected: [
      veterinarian1.full_name, veterinarian2.full_name
    ])

    fill_in 'Name', with: 'New name'
    fill_in 'Phone', with: '321 321 321'
    fill_in 'Email', with: 'new@email.com'
    unselect veterinarian1.full_name, from: 'Veterinarians'
    unselect veterinarian2.full_name, from: 'Veterinarians'
    select veterinarian3.full_name, from: 'Veterinarians'


    click_on('Update Veterinary')

    expect(current_path).to eq(veterinary_path(veterinary))
    expect(page).to have_content('Veterinary was successfully updated')
    expect(page).to have_content('New name')
    expect(page).to have_content('321 321 321')
    expect(page).to have_content('new@email.com')
    expect(page).to have_content(veterinarian3.full_name)
    expect(page).not_to have_content(veterinarian1.full_name)
    expect(page).not_to have_content(veterinarian2.full_name)
  end
end
