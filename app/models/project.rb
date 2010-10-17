class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tickets, :dependent => :destroy
  has_many :ticket_statuses, :dependent => :destroy
  belongs_to :default_status, :class_name => "TicketStatus", :foreign_key => "default_status_id"
  
  after_create :init_statuses
  
  def project_users
    users
  end
  
  def user
  end
    
  def user=(email)
    self.users << User.where('email = ?', email)
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
end
