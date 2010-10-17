class Ticket < ActiveRecord::Base
  belongs_to :project
  has_many :comments
  before_create :numbering_ticket

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
end
