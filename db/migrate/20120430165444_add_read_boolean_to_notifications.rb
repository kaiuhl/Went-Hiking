class AddReadBooleanToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :read_at, :datetime, default: nil
  end
end
