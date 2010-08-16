#
# Cookbook Name:: upload_watcher
# Recipe:: default
#
raise 'The MarketLink upload_watcher recipe is only intended for use on solo instances.' unless node[:instance_role] == 'solo'

appname = 'MarketLink'

run_for_app(appname) do |app_name, data|
  
  ey_cloud_report 'MarketLink upload_watcher' do
    message 'MarketLink - configuring upload_watcher'
  end
  
  remote_file '/etc/monit.d/upload_watcher.monitrc' do
    owner   'root'
    group   'root'
    mode    '0644'
    source  'upload_watcher.monitrc'
    backup  false
    action  :create
  end

  execute 'reload monit' do
    command 'monit reload'
  end
  
  execute 'restart upload_watcher' do
    command 'echo "sleep 20 && monit -g upload_watchers restart all" | at now'
  end

end