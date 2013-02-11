class AddStatusToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :status, :integer, :null => false, :default => 1
  end
end
