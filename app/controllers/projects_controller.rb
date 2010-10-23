class ProjectsController < InheritedResources::Base
  load_and_authorize_resource

  respond_to :js

  def create
    create! do |format|
      format.js { render :text => project_tickets_path(@project) }
    end
  end

private

  def begin_of_association_chain
    current_user
  end
end
