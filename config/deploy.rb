require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :application_name, 'tasks-api'
set :domain, 'minas-tirith'
set :deploy_to, '/home/jmscarpa/tasks-api'
set :repository, 'git@github.com:jmscarpa/tasks-api.git'
set :branch, 'main'
set :shared_files, ['.env']
set :shared_dirs, fetch(:shared_dirs, []).push('storage')

set :user, 'jmscarpa'
set :forward_agent, true

task :environment do
  invoke :'rvm:use', 'ruby-3.1.0'
end

desc "Deploys the current version to the server."
task :deploy do
  invoke :'git:ensure_pushed'
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'rvm:use', 'ruby-3.1.0'
    invoke :'bundle:install'
    invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end

end
