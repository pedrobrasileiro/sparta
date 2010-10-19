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
    can :read, Project, :open => true

    if current_user
      ##
      # Project abilities
      ##

      # Anyone can create new project
      can :create, Project

      # Only project owner can update project
      # TODO: Add multiply project owners
      can :update, Project, :user => current_user
    end
  end
end
