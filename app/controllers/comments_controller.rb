class CommentsController < InheritedResources::Base
  actions :index, :create
  nested_belongs_to :project, :ticket
  
  def index
    super do |format|
      @comment = Comment.new
      format.html do
        render :partial => 'list', :layout => false
      end
    end        
  end
end
