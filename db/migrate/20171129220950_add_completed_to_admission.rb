class AddCompletedToAdmission < ActiveRecord::Migration[5.1]
  def change
    add_column :admissions, :completed, :boolean
  end
end
