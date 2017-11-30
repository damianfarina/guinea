class CreateVeterinarians < ActiveRecord::Migration[5.1]
  def change
    create_table :veterinarians do |t|
      t.string :full_name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
