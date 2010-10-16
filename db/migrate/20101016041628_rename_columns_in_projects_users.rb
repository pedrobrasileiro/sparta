class RenameColumnsInProjectsUsers < ActiveRecord::Migration
  def self.up
    rename_column :projects_users, :user_id_id, :user_id
    rename_column :projects_users, :project_id_id, :project_id
  end

  def self.down
    rename_column :projects_users, :user_id, :user_id_id
    rename_column :projects_users, :project_id, :project_id_id
  end
end
