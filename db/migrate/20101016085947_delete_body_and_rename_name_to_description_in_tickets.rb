class DeleteBodyAndRenameNameToDescriptionInTickets < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :body
    rename_column :tickets, :name, :description
    change_column :tickets, :description, :text
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
