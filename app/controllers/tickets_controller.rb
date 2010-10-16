class TicketsController < InheritedResources::Base
  belongs_to :project
  
  def show 
    super do |format|
      @comments = @ticket.comments
      @comment = Comment.new
      format.html do
        render :layout => false
      end
    end    
  end
end
