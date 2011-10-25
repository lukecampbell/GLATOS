
namespace :db do
  desc "Make a bunch of dummy users"
  task :dummy_users => :environment do
    ENV['WEB_ADMIN_PASSWORD'] ||= "default"
    User.create! :name => "User 1", :email => 'user1@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "researcher", :approved => true
    User.create! :name => "User 2", :email => 'user2@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :role => "investigator", :approved => false
    User.create! :name => "User 3", :email => 'user3@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :approved => false
    User.create! :name => "User 4", :email => 'user4@asascience.com', :password => ENV['WEB_ADMIN_PASSWORD'], :password_confirmation => ENV['WEB_ADMIN_PASSWORD'], :approved => false
  end
end
