class AddCommentNotifications < ActiveRecord::Migration
  def self.up
		add_column :users, :notify_on_comment, :boolean, :default => true
  end

  def self.down
		remove_column :users, :notify_on_comment
  end
end