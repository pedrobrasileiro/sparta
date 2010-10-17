class ChangeClosedColumnInTicket < ActiveRecord::Migration
  def self.up
    change_column :tickets, :closed, :boolean, :default => false
  end

  def self.down
    change_column :tickets, :closed, :boolean
  end
end
