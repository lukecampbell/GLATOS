class UserObserver < ActiveRecord::Observer
  def after_create(user)
    # Send email to administrator
  end
end
