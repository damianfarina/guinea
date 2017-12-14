class Admission < ApplicationRecord
  attribute :completed, :boolean, default: false

  belongs_to :petitioner, polymorphic: true

  enum species: {canine: 1, feline: 2, equine: 3}
  enum sex: {male: 1, female: 2}
end
