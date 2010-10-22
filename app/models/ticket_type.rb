class TicketType < ActiveRecord::Base
  belongs_to :project
  has_many :tickets, :foreign_key => 'type_id'
end
