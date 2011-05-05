class CreateForecasts < ActiveRecord::Migration
  def self.up
    create_table :forecasts do |t|
      t.float :lat
      t.float :lng
      t.text :details

      t.timestamps
    end
  end

  def self.down
    drop_table :forecasts
  end
end
