set :application, "GLATOS"
set :scm, :git
set :repository,  "git@github.com:asascience-open/GLATOS.git"
set :deploy_to, "/home/glatos/application"
set :user, "glatos"
set :use_sudo, false
set :branch, "master"
set :keep_releases, 5
set :deploy_via, :remote_cache

task :production do
  set :rails_env, "production"
  set :domain, "data.glos.us"
	role :web,"glos.us"
	role :db, "glos.us", :primary => true
end

task :staging do
  set :rails_env, "staging"
  set :domain, "glatos.asascience.com"
	role :web, "ec2-50-19-25-251.compute-1.amazonaws.com"
	role :db, "ec2-50-19-25-251.compute-1.amazonaws.com", :primary => true
end

after "deploy:update_code","deploy:migrate"
after "deploy:update", "deploy:cleanup"

namespace :deploy do
	task :restart, :roles => :web do
		run "touch #{latest_release}/tmp/restart.txt"
	end
  desc "Run rake db:seed"
  task :seed, :roles => :db, :only => { :primary => true } do
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} bundle exec rake db:seed"
  end
  desc "Run rake db:migrate"
  task :migrate, :roles => :db, :only => { :primary => true } do
    run "cd #{latest_release}; RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
  end
end

require "bundler/capistrano"
