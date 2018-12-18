class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new
    if user.has_role?
        can :manage, :all # admin có tất cả các quyền
    else
        # Only upadte own question
        can :update, Question do |question|
            question.user == user
        end

        # Only upadte own info
        can :update, User do |users|
            users == user
        end

        # Only read own info
        can :read, User do |users|
            users == user
        end

        # Only delete own question
        can :destroy, Question do |question|
            question.user == user
        end

        # Only delete own answer
        can :destroy, Answer do |answer|
            answer.user == user
        end

        # If member is user then can create question and answer
        can :create, Question
        can :create, Answer
        can :read, Question
        can :read, Answer
        can :read, Article
    end
  end
end
