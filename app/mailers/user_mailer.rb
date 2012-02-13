class UserMailer < ActionMailer::Base

  def new_account(user)
    @user = user
    recips = User.where("role = 'admin'").map(&:email)
    mail(:to => recips, :subject => "[GLATOS] New Account")
  end

  def request_role(user)
    @user = user
    recips = User.where("role = 'admin'").map(&:email)
    mail(:to => recips, :subject => "[GLATOS] Role Upgrade Request")
  end

  def account_approved(user)
    @user = user
    recips = user.email
    mail(:to => recips, :subject => "[GLATOS] Account Approved")
  end

end
