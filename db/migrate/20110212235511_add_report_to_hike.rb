class AddReportToHike < ActiveRecord::Migration
  def self.up
		add_column :hikes, :report, :text
  end

  def self.down
		remove_column :hikes, :report
  end
end