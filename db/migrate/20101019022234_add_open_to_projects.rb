class AddOpenToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :open, :boolean, :default => false
  end

  def self.down
    remove_column :projects, :open
  end
end
