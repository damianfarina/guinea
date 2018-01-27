class CreatesAdmission
  attr_accessor \
    :admission,
    :veterinarian_id,
    :veterinary_id,
    :petitioner_name,
    :petitioner_phone,
    :petitioner_email,
    :patient_name,
    :species,
    :sex,
    :breed,
    :age,
    :owner_name,
    :comments

  def initialize(attributes = {})
    attributes = HashWithIndifferentAccess.new(attributes)

    @veterinarian_id = attributes[:veterinarian_id]
    @veterinary_id = attributes[:veterinary_id]
    @petitioner_name = attributes[:petitioner_name]
    @petitioner_phone = attributes[:petitioner_phone]
    @petitioner_email = attributes[:petitioner_email]
    @patient_name = attributes[:patient_name]
    @species = attributes[:species]
    @sex = attributes[:sex]
    @breed = attributes[:breed]
    @owner_name = attributes[:owner_name]
    @age = attributes[:age]
    @comments = attributes[:comments]

    @success = false
  end

  def success?
    @success
  end

  def build
    self.admission = Admission.new(
      veterinarian_id: veterinarian_id,
      veterinary_id: veterinary_id,
      petitioner_name: petitioner_name,
      petitioner_phone: petitioner_phone,
      petitioner_email: petitioner_email,
      patient_name: patient_name,
      species: species,
      sex: sex,
      breed: breed,
      age: age,
      owner_name: owner_name,
      comments: comments,
      created_at: Time.current
    )
    admission
  end

  def create
    build
    result = admission.save
    @success = result
  end
end
