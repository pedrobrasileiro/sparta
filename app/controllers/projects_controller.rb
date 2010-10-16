class ProjectsController < InheritedResources::Base
  def create
    create!
    current_user.projects << @project
  end
end
