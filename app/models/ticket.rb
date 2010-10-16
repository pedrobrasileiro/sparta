class Ticket < ActiveRecord::Base
  belongs_to :project
  
  before_create :numbering_ticket

  private

  def numbering_ticket
    self.number = if self.project.tickets(true).size > 0
      self.project.tickets.last.number + 1
    else
      1
    end
  end
end
