class TicketsController < InheritedResources::Base
  actions :index, :show, :new, :create, :edit, :update, :destroy
  belongs_to :project

  respond_to :js

  def show
    super do |format|
      @comments = @ticket.comments
      @comment = Comment.new
      format.html do
        render :layout => false
      end
    end
  end

  def create
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.build params[:ticket]
    @ticket.reporter_id = current_user
    create! do |format|
      format.js { render :partial => 'ticket', :locals => { :ticket => @ticket } }
    end
  end

  def destroy
    destroy! do |format|
      format.js { render :nothing => true }
    end
  end

  def sort
    Ticket.order params[:ticket]
    render :nothing => true
  end

  def bulk_delete
    Ticket.delete params[:ticket]
    render :nothing => true
  end
end
