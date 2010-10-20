class Ticket < ActiveRecord::Base
  belongs_to :project
  has_many :comments, :dependent => :destroy
  belongs_to :status, :class_name => 'TicketStatus', :foreign_key => 'status_id'
  belongs_to :type, :class_name => 'TicketType', :foreign_key => 'type_id'
  belongs_to :assigned_to, :class_name => 'User', :foreign_key => 'assigned_to_id'
  belongs_to :reporter, :class_name => 'User', :foreign_key => 'reporter_id'
  before_create :numbering_ticket

  after_create :set_default_status
  after_create :close_if_status_close

  after_update :close_if_status_close

  default_scope :order => '"position" asc', :conditions => { :closed => false }

  acts_as_taggable

  #validates :description, :presence => true

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

  def close_if_status_close
    if !self.closed && self.status.close?
      self.closed = true
      save
    elsif self.closed && !self.status.close?
      self.closed = false
      save
    end
  end
end
