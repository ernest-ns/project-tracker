class CreateProjectUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :project_updates do |t|
      t.integer :project_id
      t.datetime :recorded_time
      t.integer :amount

      t.timestamps
    end

    add_index :project_updates, :project_id
  end
end
