class UpdateInterestRateDatatypeForProject < ActiveRecord::Migration[5.1]

  def up
    change_column :projects, :interest_rate, :text
  end

  def down
    change_column :projects, :interest_rate, :decimal
  end
end
