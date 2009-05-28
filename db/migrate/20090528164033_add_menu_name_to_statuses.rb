class AddMenuNameToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :menu_name, :string
  end

  def self.down
    remove_column :statuses, :menu_name
  end
end
