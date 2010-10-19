class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tickets, :dependent => :destroy
  has_many :ticket_statuses, :dependent => :destroy
  has_many :ticket_types, :dependent => :destroy

  belongs_to :default_status, :class_name => "TicketStatus", :foreign_key => "default_status_id"

  after_create :init_statuses, :init_types

  # Project owner
  belongs_to :user

  def project_users
    users
  end

private

  def init_statuses
    self.ticket_statuses.create([{
      :name  => 'New',
      :color => 'gray',
      :close => false
    },{
      :name  => 'Resolved',
      :color => 'green',
      :close => false
    },{
      :name  => 'Closed',
      :color => 'red',
      :close => true
    }])
    self.default_status = self.ticket_statuses.where("name = 'New'").first
    self.save
  end

  def init_types
    self.ticket_types.create([{
      :name  => 'Feature',
      :color => 'green'
    },{
      :name  => 'Bug',
      :color => 'red'
    },{
      :name  => 'Chore',
      :color => 'orange'
    }])
  end
end
