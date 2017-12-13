json.partial! 'veterinarians/veterinarian', veterinarian: veterinarian
json.veterinaries veterinarian.veterinaries,
  partial: 'veterinaries/veterinary',
  as: :veterinary
