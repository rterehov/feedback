role :app, "ec2-23-23-3-38.compute-1.amazonaws.com"
set :app_dir, File.join(base_dir, app) 
set :deploy_to, app_dir
