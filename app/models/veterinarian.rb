class Veterinarian < ApplicationRecord
  has_many :admissions, as: :petitioner

  validates :full_name, presence: true

  alias_attribute :name, :full_name
end
