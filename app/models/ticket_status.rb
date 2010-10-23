class TicketStatus < ActiveRecord::Base
  belongs_to :project
  has_many :tickets, :foreign_key => 'status_id'
  
  scope :closing, :conditions => { :close => true  }
  scope :opening, :conditions => { :close => false }
end
