set :application, "gcrdesign.no"
role :app, application
role :web, application
role :db,  application, :primary => true

set :user, "teatercamp"
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

set :scm, :git
set :repository, "git://github.com/andreaslyngstad/gcrdesign.git"
set :branch, "master"


namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"  
    run "ln -nfs #{shared_path}/public/images #{release_path}/config/images"  
  end
  
  desc "Restarting mod_rails with restart.txt"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  
  
end
after 'deploy:update_code', 'deploy:symlink_shared'