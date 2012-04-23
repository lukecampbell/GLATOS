set :application, "GLATOS"
set :scm, :git
set :repository,  "git@github.com:asascience-open/GLATOS.git"
set :user, "glatos"
set :use_sudo, false
set :branch, "master"
set :keep_releases, 5
set :deploy_via, :remote_cache

task :production do
  set :deploy_to, "/var/www/applications/GLATOS"
  set :relative_url, "/glatos"
  set :rails_env, "production"
  set :domain, "data.glos.us"
	role :web,"glos.us"
	role :db, "glos.us", :primary => true
end

task :staging do
  set :deploy_to, "/var/www/applications/GLATOS-Stage"
  set :relative_url, "/glatos-stage"
  set :rails_env, "staging"
  set :domain, "data.glos.us"
	role :web,"glos.us"
	role :db, "glos.us", :primary => true
end

after "deploy:update_code","deploy:migrate"
after "deploy:update", "deploy:cleanup"

set :asset_env, "RAILS_RELATIVE_URL_ROOT=#{relative_url} RAILS_GROUPS=assets"

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
