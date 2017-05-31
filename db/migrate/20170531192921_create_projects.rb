class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :company_id
      t.text :name
      t.integer :funding_amount
      t.text :city
      t.text :developer
      t.integer :duration_in_months
      t.decimal :intrest_rate

      t.timestamps
    end

    add_index :projects, :name, :unique => true
    add_index :projects, :company_id
  end
end
