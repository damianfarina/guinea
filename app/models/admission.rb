class Admission < ApplicationRecord
  attribute :completed, :boolean, default: false

  belongs_to :veterinarian, optional: true
  belongs_to :veterinary, optional: true

  delegate :name, to: :veterinary, prefix: true, allow_nil: true
  delegate :full_name, to: :veterinarian, prefix: true, allow_nil: true

  enum species: {canine: 1, equine: 2, feline: 3}
  enum sex: {female: 1, male: 2}

  serialize :exams

  validates \
    :petitioner_name,
    :species,
    :owner_name,
    :exams,
    presence: true
end
