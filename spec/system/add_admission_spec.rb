require 'rails_helper'

RSpec.describe 'adding an admission', type: :system do

  context 'with existing vaterinarian' do
    let!(:veterinary) { create :veterinary }
    let!(:veterinarian) { create :veterinarian, veterinaries: [veterinary] }

    before(:each) do
      visit new_admission_path
    end

    it 'should create an admission' do
      within '.petitioner' do
        select veterinarian.full_name, from: 'veterinario'
        select veterinary.name, from: 'veterinaria'
        fill_in 'nombre', with: "#{veterinarian.full_name} (#{veterinary.name})"
        fill_in 'teléfono', with: veterinarian.phone
        fill_in 'EMail', with: veterinarian.email
      end

      within '.patient' do
        fill_in 'nombre', with: 'Igor'
        choose 'Canino'
        choose 'Masculino'
        fill_in 'raza', with: 'Rottweiler'
        fill_in 'edad', with: '4a3m'
        fill_in 'propietario', with: 'Natalia'
      end
      within '.others' do
        fill_in 'comentarios', with: 'S/C'
      end

      within '.exams' do
        check 'Urea'
        check 'Creatinina'
        check 'Coagulación'
      end

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
      expect(page).to have_content('Urea')
      expect(page).to have_content('Creatinina')
      expect(page).to have_content('Coagulación')
    end

    it 'should toggle check all exams related to a category', js: true do
      # check whole category
      check 'Hemoparásitos'
      expect(page).to have_checked_field('Mycoplasma / Babesia')
      expect(page).to have_checked_field('Microfilarias')
      expect(page).to have_checked_field('Hepatozoon')

      # uncheck whole category
      uncheck 'Hemoparásitos'
      expect(page).not_to have_checked_field('Mycoplasma / Babesia')
      expect(page).not_to have_checked_field('Microfilarias')
      expect(page).not_to have_checked_field('Hepatozoon')

      # check single exam
      check 'Hepatozoon'
      expect(page).to have_checked_field('Hepatozoon')
      expect(page).not_to have_checked_field('Mycoplasma / Babesia')
      expect(page).not_to have_checked_field('Microfilarias')

      # check whole category
      check 'Piel'
      # and uncheck a single exam
      uncheck 'Raspaje de Piel'

      expect(page).not_to have_checked_field('Raspaje de Piel')
      expect(page).not_to have_checked_field('Piel')
      expect(page).to have_checked_field('Test Dermatofitos')
    end
  end
end
