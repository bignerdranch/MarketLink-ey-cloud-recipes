#
# Cookbook Name:: resque_worker
# Recipe:: default
#
raise 'The MarketLink resque_worker recipe is only intended for use on solo instances.' unless node[:instance_role] == 'solo'

appname = 'MarketLink'

run_for_app(appname) do |app_name, data|
  
  ey_cloud_report 'MarketLink resque_worker' do
    message 'MarketLink - configuring resque_worker'
  end
  
  remote_file '/etc/monit.d/resque_worker.monitrc' do
    owner   'root'
    group   'root'
    mode    '0644'
    source  'resque_worker.monitrc'
    backup  false
    action  :create
  end

  execute 'reload monit' do
    command 'monit reload'
  end
  
  execute 'restart resque_worker' do
    command 'echo "sleep 20 && monit -g resque_workers restart all" | at now'
  end

end
