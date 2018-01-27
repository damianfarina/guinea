class ChangeAdmissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :admissions, :petitioner_id, :integer
    remove_column :admissions, :petitioner_type, :string
    add_reference :admissions, :veterinarian, foreign_key: true
    add_reference :admissions, :veterinary, foreign_key: true
  end
end
