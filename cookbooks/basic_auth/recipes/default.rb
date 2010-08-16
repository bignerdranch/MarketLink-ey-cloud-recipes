#
# Cookbook Name:: basic_auth
# Recipe:: default
#
appname = 'MarketLink'

run_for_app(appname) do |app_name, data|
  
  ey_cloud_report 'MarketLink basic_auth' do
    message 'MarketLink - configuring basic authentication'
  end
  
  remote_file '/etc/nginx/servers/MarketLink/custom.locations.conf' do
    owner   'deploy'
    group   'deploy'
    mode    '0644'
    source  'custom.locations.conf'
    backup  false
    action  :create
  end
  
  remote_file '/etc/nginx/servers/htpasswd' do
    owner   'deploy'
    group   'deploy'
    mode    '0644'
    source  'htpasswd'
    backup  false
    action  :create
  end
  
  service 'nginx' do
    supports :reload => true
    action :reload
  end
  
end