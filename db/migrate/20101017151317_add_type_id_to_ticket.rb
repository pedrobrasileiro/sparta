class AddTypeIdToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :type_id, :integer
  end

  def self.down
    remove_column :tickets, :type_id
  end
end
