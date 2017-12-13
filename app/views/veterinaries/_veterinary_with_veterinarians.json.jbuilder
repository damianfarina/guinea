json.partial! 'veterinaries/veterinary', veterinary: veterinary
json.veterinarians veterinary.veterinarians,
  partial: 'veterinarians/veterinarian',
  as: :veterinarian
