class UserObserver < ActiveRecord::Observer

  def before_save(user)
    if user.requested_role_changed?
      # If the requested role is being upgraded, require an approval
      old_role = User::ROLES.index(user.requested_role_was) || User::ROLES.index('general')
      if old_role < User::ROLES.index(user.requested_role)
        UserMailer.request_role(user).deliver
      else
        user.role = user.requested_role
      end
    end
  end

  def after_create(user)
    if user.role == 'general'
      user.approve!
    else
      UserMailer.new_account(user).deliver
    end
  end
end
