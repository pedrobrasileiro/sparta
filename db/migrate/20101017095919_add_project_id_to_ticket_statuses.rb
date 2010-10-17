class AddProjectIdToTicketStatuses < ActiveRecord::Migration
  def self.up
    add_column :ticket_statuses, :project_id, :integer
  end

  def self.down
    remove_column :ticket_statuses, :project_id
  end
end
