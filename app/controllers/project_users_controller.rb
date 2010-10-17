class ProjectUsersController < InheritedResources::Base
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'

  belongs_to :project
  actions :index, :create, :destroy

  respond_to :js
  
  def index
    @project = Project.find(params[:project_id])
    @user = @project.users.new
    index!
  end

  def create        
    @project = Project.find(params[:project_id])
    @project.users << User.find_by_email(params[:user][:email])
    @user = @project.users.last
    create! { |format| format.js { render :partial => 'user', :locals => { :user => @user } } }
  end

  def destroy
    @project = Project.find(params[:project_id])
    @project.users.delete User.find(params[:id])
    redirect_to :controller => 'tickets'
  end
end
