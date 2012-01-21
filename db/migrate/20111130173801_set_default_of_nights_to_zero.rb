class SetDefaultOfNightsToZero < ActiveRecord::Migration
  def self.up
		change_column_default :hikes, :nights, 0
  end

  def self.down
		change_column_default :hikes, :nights, nil
  end
end