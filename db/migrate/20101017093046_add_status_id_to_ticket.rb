class AddStatusIdToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :status_id, :integer
  end

  def self.down
    remove_column :tickets, :status_id
  end
end
