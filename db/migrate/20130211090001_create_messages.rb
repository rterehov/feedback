class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :site_id
      t.string :name
      t.string :phone
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end
