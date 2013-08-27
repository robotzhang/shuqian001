class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank? # 游客
      cannot :manage, :all
      basic_read_only
    elsif user.has_role?(:admin) # 系统管理员 admin
      can :manage, :all
    elsif user.has_role?(:member) # 基本用户 member
      base_user_role(user)
      basic_read_only
    else
      cannot :manage, :all
      basic_read_only
    end
  end

  protected
  def base_user_role(user)
    can [:create], [Collection, Comment, Link, Vote, Like]
    can [:edit, :update, :destroy], Collection do |collection|
      (collection.user_id == user.id)
    end
    can :manage, Link do |link|
      (link.user_id == user.id)
    end
    can [:update, :logout], User do |me|
      me.id == user.id
    end
    can [:follow, :unfollow], User
    can [:update], Vote do |vote|
      vote.user_id == user.id
    end
  end

  def basic_read_only
    can [:tags], Collection
    can :read, :all
  end
end
