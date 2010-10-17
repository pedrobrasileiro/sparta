class ProjectUsersController < InheritedResources::Base
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  
  belongs_to :project
  actions :index, :destroy
  
  def destroy
    @project = Project.find(params[:project_id])
    @project.users.delete User.find(params[:id])
    redirect_to :action => :index
  end
end