class AddSubjectAssociationToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :subject_type, :string
    add_column :notifications, :subject_id, :integer
  end
end
