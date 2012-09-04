class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :to
      t.integer :from
      t.text :body
      t.string :subject

      t.timestamps
    end
  end
end
