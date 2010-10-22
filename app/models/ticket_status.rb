class TicketStatus < ActiveRecord::Base
  belongs_to :project
  has_many :tickets, :foreign_key => 'status_id'
end
