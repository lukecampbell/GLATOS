class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest
    send(@user.role)
  end

  def registered
    guest
    can :manage, User, id => @user.id
  end

  def researcher
    guest
  end

  def investigator
    researcher
  end

  def admin
    can :manage, :all
  end

end
