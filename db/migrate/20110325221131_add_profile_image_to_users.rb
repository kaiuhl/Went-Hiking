class AddProfileImageToUsers < ActiveRecord::Migration
  def self.up
		add_column :users, :avatar_file_name, :string
		add_column :users, :avatar_content_type, :string
		add_column :users, :avatar_file_size, :integer
		add_column :users, :locale, :string
  end

  def self.down
		remove_column :users, :locale
		remove_column :users, :avatar_file_size
		remove_column :users, :avatar_content_type
		remove_column :users, :avatar_file_name
  end
end