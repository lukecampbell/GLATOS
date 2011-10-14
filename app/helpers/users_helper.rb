module UsersHelper

  def user_roles
    select_tag "stuff", options_for_select(User::ROLES.map{|r|[r.humanize,r]}), :class => 'roller'
  end

end
