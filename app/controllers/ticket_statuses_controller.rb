class TicketStatusesController < InheritedResources::Base
  belongs_to :project
  actions :index, :new, :create, :edit, :update, :destroy
  
  def create
    create! { redirect_to :action => :index}
  end
  
  def update
    update! { redirect_to :action => :index}
  end
end
