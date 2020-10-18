class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user ||= User.new # guest user (not logged in)
    send @user.role.to_sym
  end

  def visitor
  end

  def editor
    can :read, Article
    can :manage, Article, author_id: @user.id
    cannot :publish, Article
  end

  def admin
    can :manage, :all
  end
end
