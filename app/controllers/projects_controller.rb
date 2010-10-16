class ProjectsController < InheritedResources::Base
  actions :index, :new, :create, :edit, :update, :destroy
  
  def create
    create!
    current_user.projects << @project
  end
  
  private
  
  def begin_of_association_chain
    @current_user
  end
end
