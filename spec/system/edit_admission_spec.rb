require 'rails_helper'

RSpec.describe 'editing an admission', type: :system do
  let(:veterinary) { create :veterinary }
  let(:veterinarian) { create :veterinarian, veterinaries: [veterinary] }
  let(:admission) do
    create :admission,
      veterinary: veterinary,
      veterinarian: veterinarian,
      petitioner_name: "#{veterinarian.full_name} (#{veterinary.name})",
      petitioner_email: veterinarian.email,
      petitioner_phone: veterinarian.phone,
      exams: ['Urianálisis', 'Relación P:C', 'Análisis Cálculos Urinarios', 'Raspaje de Piel', 'Test Dermatofitos']
  end

  before(:each) do
    visit edit_admission_path(admission)
  end

  it 'should display the form', js: true do
    within '.petitioner' do
      expect(page).to have_select('veterinaria', with_selected: veterinary.name)
      expect(page).to have_select('veterinario', with_selected: veterinarian.full_name)
      expect(page).to have_field('nombre', with: "#{veterinarian.full_name} (#{veterinary.name})")
      expect(page).to have_field('teléfono', with: veterinarian.phone)
      expect(page).to have_field('EMail', with: veterinarian.email)
    end

    within '.exams' do
      expect(page).to have_field('Orina', checked: true)
      expect(page).to have_field('Urianálisis', checked: true)
      expect(page).to have_field('Relación P:C', checked: true)
      expect(page).to have_field('Análisis Cálculos Urinarios', checked: true)
      expect(page).to have_field('Piel', checked: true)
      expect(page).to have_field('Raspaje de Piel', checked: true)
      expect(page).to have_field('Test Dermatofitos', checked: true)

      expect(page).to have_field('Urea', checked: false)
      expect(page).to have_field('Coagulación', checked: false)
    end

    within '.exams' do
      uncheck 'Orina'
      uncheck 'Piel'
      check 'Urea'
      check 'Coagulación'
    end

    click_on('actualizar orden de ingreso')

    expect(page).to have_content('actualizado correctamente')
    expect(page).to have_content("#{veterinarian.full_name} (#{veterinary.name})")
    expect(page).to have_content(veterinarian.phone)
    expect(page).to have_content(veterinarian.email)
    expect(page).to have_content('Urea')
    expect(page).to have_content('Coagulación')
    expect(page).not_to have_content('Orina')
    expect(page).not_to have_content('Urianálisis')
    expect(page).not_to have_content('Relación P:C')
    expect(page).not_to have_content('Análisis Cálculos Urinarios')
    expect(page).not_to have_content('Piel')
    expect(page).not_to have_content('Raspaje de Piel')
    expect(page).not_to have_content('Test Dermatofitos')
  end
end
