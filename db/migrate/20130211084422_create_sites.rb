class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :user_id, :null => false
      t.string :domain, :null => false
      t.string :email, :null => false, :default => ""

      t.timestamps
    end
  end
end
