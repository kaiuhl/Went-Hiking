class AddStatsToPhoto < ActiveRecord::Migration
  def self.up
		add_column :photos, :stats_added, :boolean, :default => false
  end

  def self.down
		remove_column :photos, :stats_added
  end
end