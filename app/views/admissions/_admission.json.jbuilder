json.extract! admission, :id, :petitioner_id, :petitioner_name, :petitioner_type, :phone, :email, :patient_name, :species, :sex, :breed, :months, :owner_name, :created_at, :updated_at
json.url admission_url(admission, format: :json)
