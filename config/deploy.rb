require 'bundler/capistrano'

set :application, 'spartapp.com'
set :host, application

role :app, host
role :web, host
role :db,  host, :primary => true

set :user,       'apps'
set :deploy_to,  '/home/apps/apps/spartapp.com'
set :deploy_via, :remote_cache

set :scm,        'git'
set :repository, 'git@github.com:railsrumble/rr10-team-15.git'
set :branch,     'master'

set :keep_releases, 3

set :use_sudo,   false

# Deploy task

namespace :deploy do
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :restart do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end
end

namespace :db do
  task :migrate do
    run "cd #{release_path} && rake db:migrate RAILS_ENV=production"
  end
end

after 'deploy:update_code',     'deploy:symlink_shared'
after 'gems:install',           'db:migrate'
after 'db:migrate',             'deploy:cleanup'
