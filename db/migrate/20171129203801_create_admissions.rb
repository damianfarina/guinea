class CreateAdmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :admissions do |t|
      t.references :petitioner, polymorphic: true, index: true
      t.string :petitioner_name
      t.string :petitioner_phone
      t.string :petitioner_email
      t.string :patient_name
      t.integer :species
      t.integer :sex
      t.string :breed
      t.integer :months
      t.string :owner_name

      t.timestamps
    end
  end
end
