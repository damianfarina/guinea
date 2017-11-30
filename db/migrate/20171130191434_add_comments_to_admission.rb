class AddCommentsToAdmission < ActiveRecord::Migration[5.1]
  def change
    add_column :admissions, :comments, :text
  end
end
