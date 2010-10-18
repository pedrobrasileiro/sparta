class Ability
  include CanCan::Ability

  def initialize current_user
    # Unauthrorized users can read common pages
    can :read, :common_page

    if current_user

    end
  end
end
