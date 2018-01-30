class Exam

  class << self
    def category_names
      hierarchy.map { |category| category[:name] }
    end

    def for_category(category_name)
      category = hierarchy.find { |cat| cat[:name] == category_name }
      category[:exams]
    end

    def hierarchy
      [
        {
          name: 'Bioquímica',
          exams: [
            'Urea',
            'Creatinina',
            'GPT/ALT',
            'GOT/AST',
            'FAL',
            'GGT',
            'Prot Total',
            'Alb/Glob',
            'Bilirrubina',
            'Amilasa',
            'Lipasa',
            'Glucosa',
            'Colesterol',
            'Triglicéridos',
            'CPK',
            'Calcio',
            'Fósforo'
          ]
        }, {
          name: 'Hemoparásitos',
          exams: [
            'Mycoplasma / Babesia',
            'Microfilarias',
            'Hepatozoon'
          ]
        }, {
          name: 'Perfil lipídico',
          exams: [
            'Perfil lipídico',
            'Ionograma'
          ]
        }, {
          name: 'Efusión',
          exams: [
            'abdomen, toráx, pericardio',
            'parámetros bioquímicos'
          ]
        }, {
          name: 'Orina',
          exams: [
            'Urianálisis',
            'Relación P:C',
            'Análisis Cálculos Urinarios'
          ]
        }, {
          name: 'Cito',
          exams: [
            'Citología Gral.',
            'Citología Vaginal'
          ]
        }, {
          name: 'Piel',
          exams: [
            'Raspaje de Piel',
            'Test Dermatofitos'
          ]
        }, {
          name: 'Inmunodiagnóstico',
          exams: [
            'Brucella canis',
            'Distemper Canino',
            'Erlichia canis',
            'Dirofilaria immitis',
            'Parvovirus Canino',
            'VIF-VLeF',
            'PIF (Coronavirus felino)',
            'Coronavirus felino (PIF) (IFI)',
            'Distemper canino (IFI)',
            'Herpesvirus canino (IFI)',
            'Neosporosis canina (IFI)',
            'Toxoplasmosis',
            'Leptospirosis',
            'Leishmaniasis'
          ]
        }, {
          name: 'Bioquímica II',
          exams: [
            'Tripsina inmunorreactiva',
            'Proteinograma',
            'Ácidos biliares',
            'Fructosamina',
            'Fosfatasa alcalina ósea'
          ]
        }, {
          name: 'Hormonas',
          exams: [
            'Progesterona',
            'Cortisol (CMIA)',
            'TSH',
            'T4 libre específica',
            'T4 total',
            'T3',
            'Insulina',
            'Estradiol',
            'Testosterona'
          ]
        }, {
          name: 'Drogas terapéuticas',
          exams: [
            'Bromuro',
            'Difenilhidantoina',
            'Digoxina',
            'Fenobarbital'
          ]
        }, {
          name: 'Alergenos',
          exams: [
            'Panel Completo',
            'Pulgas',
            'Stafilococo',
            'Malassezia',
            'Iniciación',
            'Mantenimiento'
          ]
        }, {
          name: 'Otros',
          exams: [
            'Hemograma',
            'Coproparasitológico',
            'Coagulación',
            'Cultivo y Antibiograma',
            'Autovacuna Papiloma',
            'PCR ¿Cuál?'
          ]
        }
      ]
    end
  end

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def in_category?(category_name)
    _category[:name] == category_name if _category
  end

  def category_name
    _category[:name] if _category.present?
  end

private

  def _category
    @_category ||= Exam.hierarchy.find { |category|
      category if category[:exams].include? self.name
    }
  end
end
