class AddClosedToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :closed, :boolean
  end

  def self.down
    remove_column :tickets, :closed, :boolean
  end
end
