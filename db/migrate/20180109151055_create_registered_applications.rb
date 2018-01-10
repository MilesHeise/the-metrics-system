class CreateRegisteredApplications < ActiveRecord::Migration
  def change
    create_table :registered_applications do |t|
      t.string :name
      t.text :url
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :registered_applications, :user_id
  end
end
