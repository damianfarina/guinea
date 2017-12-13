class Veterinary < ApplicationRecord
  has_many :admissions, as: :petitioner
  has_many :employments
  has_many :veterinarians, through: :employments

  validates :name, presence: true
  validates :phone, uniqueness: true, if: -> { phone.present? }
  validates :email, uniqueness: true, email: true, if: -> { email.present? }
end
