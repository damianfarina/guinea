class RemoveMonthsFromAdmissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :admissions, :months, :integer
    add_column :admissions, :age, :string
  end
end
