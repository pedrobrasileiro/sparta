class ProjectsController < InheritedResources::Base
  load_and_authorize_resource

  actions :index, :new, :create, :edit, :update, :destroy

  respond_to :js

  def create
    create! do |format|
      current_user.projects << @project
      format.js { render :text => project_tickets_path(@project) }
    end
  end

  private

  def begin_of_association_chain
    current_user
  end
end
