class AddNumberColumnToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :number, :integer
  end

  def self.down
    remove_column :tickets, :number, :integer
  end
end
