class Ticket < ActiveRecord::Base
  belongs_to :project
  has_many :comments
  belongs_to :status, :class_name => 'TicketStatus', :foreign_key => 'status_id'
  belongs_to :assigned_to, :class_name => 'User', :foreign_key => 'assigned_to_id'
  belongs_to :reporter, :class_name => 'User', :foreign_key => 'reporter_id'
  before_create :numbering_ticket
  after_create :set_default_status
  
  default_scope :order => '"position" asc'

  def self.order ids
    update_all(
      ['"position" = find_in_set("id"::text, ?)', ids.join(',')],
      { :id => ids }
    )
  end  

private

  def numbering_ticket
    self.number = if self.project.tickets(true).size > 0
      self.project.tickets.maximum('number') + 1
    else
      1
    end
  end
  
  def set_default_status
    unless self.status
      self.status = project.default_status
      save
    end
  end
end
