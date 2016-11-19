class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.date :start_date
      t.date :end_date
      t.string :function
      t.integer :employee_id

      t.timestamps
    end
    add_index :contracts, :employee_id
  end
end
