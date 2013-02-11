class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :user_id
      t.string :domain
      t.string :email

      t.timestamps
    end
  end
end
