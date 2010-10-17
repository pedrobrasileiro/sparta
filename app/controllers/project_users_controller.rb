class ProjectUsersController < InheritedResources::Base
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'

  belongs_to :project
  actions :index, :destroy

  respond_to :js

  def create
    create! { |format| format.js { render :partial => 'user', :locals => { :user => @user } } }
  end

  def destroy
    @project = Project.find(params[:project_id])
    @project.users.delete User.find(params[:id])
    redirect_to :action => :index
  end
end
