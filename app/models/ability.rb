class Ability
  include CanCan::Ability

  def initialize current_user

    ##
    # Project abilities
    ##

    # Unauthrorized users can...

    # ... view common pages
    can :read, :common_page

    # ... view open projects
    can :read, Project do |project|
      project.open?
    end

    if current_user

      ##
      # Project abilities
      ##

      # If project os open or user have access
      can :read, Project do |project|
        project.open? or project.users.include?(current_user)
      end

      # Anyone can create new project
      can :create, Project

      # Only project owner can update project
      # TODO: Add multiply project owners
      can :update, Project, :user => current_user

      ##
      # Tickets abilities
      ##
      can :read, Ticket
    end
  end
end
