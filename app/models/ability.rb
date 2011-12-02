class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new(:role => :guest) # for guest
    send(@user.role)
  end

  def guest
    can :create, Report
    can :read, Deployment
  end

  def public
    guest
    can :manage, User, :id => @user.id
  end

  def researcher
    registered
    can :read, Report
  end

  def investigator
    researcher
    can :manage, Study, :user_id => @user.id
    can :manage, Tag, :study => { :user_id => @user.id }
  end

  def admin
    can :manage, :all
  end

end
