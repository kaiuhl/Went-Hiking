class AddUserIdToForecasts < ActiveRecord::Migration
  def self.up
		add_column :forecasts, :user_id, :integer
  end

  def self.down
		remove_column :forecasts, :user_id
  end
end