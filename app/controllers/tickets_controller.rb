class TicketsController < InheritedResources::Base
  actions :index, :show, :new, :create, :edit, :update, :destroy
  belongs_to :project

  respond_to :js

  def index
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.new

    @tags = Ticket.tag_counts_on(:tags)
    if params[:tags]
      @tickets = {}
      @tickets[:both] = [params[:tags].gsub(', ', ',').split(',').map(&:capitalize).join(', '), @project.tickets.tagged_with(params[:tags])]
      @tickets[:other] = params[:tags].gsub(', ', ',').split(',').map do |tag|
        [tag.capitalize, (@project.tickets.tagged_with(tag) - @tickets[:both][1])]
      end
    else
      @tickets = @project.tickets
    end
  end

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

  def update
    update! do |format|
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

  def bulk_update
    tickets = Ticket.update_all(params[:ticket], ["id IN (?)", params[:ticket_ids]])
    render :json => {
      :tickets => Ticket.find(params[:ticket_ids]).map { |ticket| render_to_string :partial => 'ticket', :locals => { :ticket => ticket } }
    }
  end
end
