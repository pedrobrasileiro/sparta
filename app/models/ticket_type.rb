class TicketType < ActiveRecord::Base
  belongs_to :project
  has_many :tickets
end
