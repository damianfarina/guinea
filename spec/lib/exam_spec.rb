require 'rails_helper'

RSpec.describe Exam do

  it 'should return categories' do
    categories = Exam.category_names
    expect(categories.count).to eq(13)
    expect(categories[0]).to eq('Bioquímica')
    expect(categories[1]).to eq('Hemoparásitos')
    expect(categories[2]).to eq('Perfil lipídico')
    expect(categories[3]).to eq('Efusión')
    expect(categories[4]).to eq('Orina')
    expect(categories[5]).to eq('Cito')
    expect(categories[6]).to eq('Piel')
    expect(categories[7]).to eq('Inmunodiagnóstico')
    expect(categories[8]).to eq('Bioquímica II')
    expect(categories[9]).to eq('Hormonas')
    expect(categories[10]).to eq('Drogas terapéuticas')
    expect(categories[11]).to eq('Alergenos')
    expect(categories[12]).to eq('Otros')
  end

  it 'should return exams by category' do
    exams = Exam.for_category_name('Bioquímica')
    expect(exams.count).to be(17)
    expect(exams.first).to eq('Urea')
    expect(exams.last).to eq('Fósforo')

    exams = Exam.for_category_name('Hemoparásitos')
    expect(exams.count).to be(3)
    expect(exams.first).to eq('Mycoplasma / Babesia')
    expect(exams.last).to eq('Hepatozoon')

    exams = Exam.for_category_name('Perfil lipídico')
    expect(exams.count).to be(2)
    expect(exams.first).to eq('Perfil lipídico')
    expect(exams.last).to eq('Ionograma')

    exams = Exam.for_category_name('Efusión')
    expect(exams.count).to be(2)
    expect(exams.first).to eq('abdomen, toráx, pericardio')
    expect(exams.last).to eq('parámetros bioquímicos')

    exams = Exam.for_category_name('Orina')
    expect(exams.count).to be(3)
    expect(exams.first).to eq('Urianálisis')
    expect(exams.last).to eq('Análisis Cálculos Urinarios')

    exams = Exam.for_category_name('Cito')
    expect(exams.count).to be(2)
    expect(exams.first).to eq('Citología Gral.')
    expect(exams.last).to eq('Citología Vaginal')

    exams = Exam.for_category_name('Piel')
    expect(exams.count).to be(2)
    expect(exams.first).to eq('Raspaje de Piel')
    expect(exams.last).to eq('Test Dermatofitos')

    exams = Exam.for_category_name('Inmunodiagnóstico')
    expect(exams.count).to be(14)
    expect(exams.first).to eq('Brucella canis')
    expect(exams.last).to eq('Leishmaniasis')

    exams = Exam.for_category_name('Bioquímica II')
    expect(exams.count).to be(5)
    expect(exams.first).to eq('Tripsina inmunorreactiva')
    expect(exams.last).to eq('Fosfatasa alcalina ósea')

    exams = Exam.for_category_name('Hormonas')
    expect(exams.count).to be(9)
    expect(exams.first).to eq('Progesterona')
    expect(exams.last).to eq('Testosterona')

    exams = Exam.for_category_name('Drogas terapéuticas')
    expect(exams.count).to be(4)
    expect(exams.first).to eq('Bromuro')
    expect(exams.last).to eq('Fenobarbital')

    exams = Exam.for_category_name('Alergenos')
    expect(exams.count).to be(6)
    expect(exams.first).to eq('Panel Completo')
    expect(exams.last).to eq('Mantenimiento')

    exams = Exam.for_category_name('Otros')
    expect(exams.count).to be(6)
    expect(exams.first).to eq('Hemograma')
    expect(exams.last).to eq('PCR ¿Cuál?')
  end

  it 'should tell whether an exam belongs to a category' do
    exam = Exam.new('Urea')
    expect(exam.in_category?('Bioquímica')).to be(true)
    expect(exam.in_category?('Bioquímica II')).to be(false)
    expect(exam.in_category?('Alergenos')).to be(false)
    expect(exam.in_category?('Non Existant')).to be(false)
  end

  it 'should know the associated category name' do
    exam = Exam.new('Urea')
    expect(exam.category_name).to eq('Bioquímica')
    expect(exam.category_name).not_to eq('Otro')
  end
end
