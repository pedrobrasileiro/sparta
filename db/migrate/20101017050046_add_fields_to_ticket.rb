class AddFieldsToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :reporter_id, :integer
    add_column :tickets, :assigned_to_id, :integer
  end

  def self.down
    remove_column :tickets, :reporter_id
    remove_column :tickets, :assigned_to_id
  end
end
