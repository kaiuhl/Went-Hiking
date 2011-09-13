class AddTitleAndWeatherInfoToForecasts < ActiveRecord::Migration
  def self.up
		add_column :forecasts, :title, :string
  end

  def self.down
		remove_column :forecasts, :column_name
  end
end