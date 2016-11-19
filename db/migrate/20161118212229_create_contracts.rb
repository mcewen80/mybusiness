class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.date :start_date
      t.date :end_date
      t.string :function

      t.timestamps
    end
  end
end
