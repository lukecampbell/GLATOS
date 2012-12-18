Given /^no user has an account with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Given /^I am logged in as an admin$/ do
  user = FactoryGirl.build(:admin_user)
  step %{I sign in as "#{user.email}/#{user.password}"}
end

Given /^I am logged in as an approved user$/ do
  user = FactoryGirl.build(:approved_user)
  step %{I sign in as "#{user.email}/#{user.password}"}
end

Then /^I should be already signed in$/ do
  visit root_path
  step %{I should see "Logout"}
end

Given /^a(?:|n) ([a-z \s]*) has an account$/ do |t|
  # Make an appropriate account, ie:
  # "approved user", "user", "admin user", "approved investigator"
  user = FactoryGirl.create(t.gsub(" ", "_").to_sym)
  store_model('user', 'me', user)
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  step %{I am not logged in}
  step %{I go to the sign up page}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  step %{I press "Sign up"}
  step %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  step %{I am logged out}
end

Then /^I sign out$/ do
  visit root_path
  click_link "Logout" if page.has_content?('Logout')
end

Given /^I am logged out$/ do
  step %{I sign out}
end

Given /^I am not logged in$/ do
  step %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  step %{I am not logged in}
  step %{I go to the sign in page}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  visit root_path
  step %{I should see "Logout"}
  step %{I should not see "Login"}
end

When /^I return next time$/ do
  step %{I go to the home page}
end

Then /^I should be signed out$/ do
  visit root_path
  step %{I should see "Login"}
  step %{I should see "Register to Join the GLATOS Network"}
  step %{I should not see "Logout"}
end
