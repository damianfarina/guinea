class AddExamsToAdmission < ActiveRecord::Migration[5.1]
  def change
    add_column :admissions, :exams, :string
  end
end
