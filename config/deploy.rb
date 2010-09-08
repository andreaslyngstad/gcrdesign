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

# ==============================
# Uploads
# ==============================

namespace :uploads do

  desc <<-EOD
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  EOD
  task :setup, :except => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
  end

  desc <<-EOD
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  EOD
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc <<-EOD
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.
  EOD
  task :register_dirs do
    set :uploads_dirs,    %w(uploads uploads/partners)
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after       "deploy:finalize_update", "uploads:symlink"
  on :start,  "uploads:register_dirs"

end
namespace :deploy do
  [:start, :stop].each do |t|
    desc "ignore #{t} since we are using passenger"
    task t do ; end
  end
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"  
 
  end
  
  desc "Restarting mod_rails with restart.txt"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  
  
end
after 'deploy:update_code', 'deploy:symlink_shared'
after "deploy", "deploy:cleanup"