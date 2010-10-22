class TicketStatusesController < InheritedResources::Base
  load_and_authorize_resource

  belongs_to :project
  actions :index, :new, :create, :edit, :update, :destroy

  load_and_authorize_resource :project
  load_and_authorize_resource :ticket_status, :through => :project

  def create
    create! { redirect_to :action => :index}
  end

  def update
    update! { redirect_to :action => :index}
  end
end
