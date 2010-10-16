class TicketsController < InheritedResources::Base
  belongs_to :project
end
