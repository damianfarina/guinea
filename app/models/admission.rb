class Admission < ApplicationRecord
  attribute :completed, :boolean, default: false

  belongs_to :veterinarian, optional: true
  belongs_to :veterinary, optional: true

  enum species: {canine: 1, equine: 2, feline: 3}
  enum sex: {female: 1, male: 2}

  validates \
    :petitioner_name,
    :species,
    :owner_name,
    presence: true
end
