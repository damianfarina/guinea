class Veterinary < ApplicationRecord
  has_many :admissions, as: :petitioner
end
