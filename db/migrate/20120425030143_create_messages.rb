class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :recipient_id
      t.integer :author_id
      t.text :body
      t.string :subject
      t.boolean :read

      t.timestamps
    end
  end
end
