class Employment < ApplicationRecord
  belongs_to :veterinary
  belongs_to :veterinarian
end
