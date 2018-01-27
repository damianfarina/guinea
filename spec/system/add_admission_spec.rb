require 'rails_helper'

RSpec.describe 'adding an admission', type: :system do

  context 'with existing vaterinarian' do
    let!(:veterinary) { create :veterinary }
    let!(:veterinarian) { create :veterinarian, veterinaries: [veterinary] }

    before(:each) do
      visit new_admission_path
    end

    it 'should create an admission', js: true do
      select veterinarian.full_name, from: 'veterinario'
      select veterinary.name, from: 'veterinaria'
      fill_in 'solicitante', with: "#{veterinarian.full_name} (#{veterinary.name})"
      fill_in 'teléfono', with: veterinarian.phone
      fill_in 'EMail', with: veterinarian.email
      fill_in 'paciente', with: 'Igor'
      choose 'canino'
      choose 'masculino'
      fill_in 'raza', with: 'Rottweiler'
      fill_in 'edad', with: '4a3m'
      fill_in 'propietario', with: 'Natalia'
      fill_in 'comentarios', with: 'S/C'
      # screenshot_and_open_image
      click_on('guardar orden de ingreso')

      expect(page).to have_content('guardado correctamente')
      expect(page).to have_content("#{veterinarian.full_name} (#{veterinary.name})")
      expect(page).to have_content(veterinarian.phone)
      expect(page).to have_content(veterinarian.email)
      expect(page).to have_content('Igor')
      expect(page).to have_content('canino')
      expect(page).to have_content('masculino')
      expect(page).to have_content('Rottweiler')
      expect(page).to have_content('4a3m')
      expect(page).to have_content('S/C')
    end
  end
end
