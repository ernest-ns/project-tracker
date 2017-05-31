class FixInterestRateColumnForProject < ActiveRecord::Migration[5.1]
  def up
    rename_column :projects, :intrest_rate, :interest_rate
  end

  def down
    rename_column :projects, :interest_rate, :intrest_rate
  end
end
