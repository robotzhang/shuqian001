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
    can [:edit, :update], Store do |store|
      (store.user_id == user.id)
    end
    can [:create], Store
    can :manage, Theme do |theme|
      (theme.store.user_id == user.id)
    end
    can :manage, Link do |link|
      (link.store.user_id == user.id)
    end
    can :manage, Contact do |contact|
      (contact.user_id == user.id)
    end
    can [:update, :logout], User do |me|
      me.id == user.id
    end
  end

  def basic_read_only
    can :read, :all
  end
end
