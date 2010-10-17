class AddDefaultStatusToRpoject < ActiveRecord::Migration
  def self.up
    add_column :projects, :default_status_id, :integer
  end

  def self.down
    remove_column :projects, :default_status_id
  end
end
