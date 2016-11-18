class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :initials
      t.date :date_of_birth
      t.integer :bsn

      t.timestamps
    end
  end
end
