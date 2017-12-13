json.extract! veterinary,
  :id,
  :name,
  :phone,
  :email,
  :created_at,
  :updated_at
json.url veterinary_url(veterinary, format: :json)
