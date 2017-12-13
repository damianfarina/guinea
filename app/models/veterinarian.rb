class Veterinarian < ApplicationRecord
  has_many :admissions, as: :petitioner
  has_many :employments
  has_many :veterinaries, through: :employments

  validates :full_name, presence: true
  validates :phone, uniqueness: true, if: -> { phone.present? }
  validates :email, uniqueness: true, email: true, if: -> { email.present? }

  alias_attribute :name, :full_name
end
