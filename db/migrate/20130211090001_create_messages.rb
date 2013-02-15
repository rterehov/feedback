class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :site_id, :null => false
      t.string :name, :null => false
      t.string :phone
      t.string :email
      t.text :message, :null => false

      t.timestamps
    end
  end
end
