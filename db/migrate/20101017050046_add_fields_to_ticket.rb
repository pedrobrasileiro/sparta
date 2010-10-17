class AddFieldsToTicket < ActiveRecord::Migration
  def self.up
    add_column :ticket, :reporter_id, :integer
    add_column :ticket, :assigned_to_id, :integer
  end

  def self.down
    remove_column :ticket, :reporter_id
    remove_column :ticket, :assigned_to_id
  end
end
