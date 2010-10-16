class CreateTableProjectsUsers < ActiveRecord::Migration
  def self.up
    create_table :projects_users, :id => false do |t|
      t.references :user_id
      t.references :project_id
    end
  end

  def self.down
    drop_table :projects_users
  end
end
