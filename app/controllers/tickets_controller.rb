class TicketsController < InheritedResources::Base
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

  def sort
    Ticket.order params[:ticket]
    render :nothing => true
  end
end
