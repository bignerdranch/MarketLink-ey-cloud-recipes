#
# Cookbook Name:: proftpd
# Recipe:: default
#
raise 'The MarketLink proftpd recipe is only intended for use on solo instances.' unless node[:instance_role] == 'solo'

appname = 'MarketLink'

run_for_app(appname) do |app_name, data|
  
  ey_cloud_report 'MarketLink proftpd' do
    message 'MarketLink - configuring proftpd'
  end
  
  remote_file '/etc/proftpd/proftpd.conf' do
    owner   'root'
    group   'root'
    mode    '0755'
    source  'proftpd.conf'
    backup  false
    action  :create
  end
  
  service 'proftpd' do
    action :start
  end
  
end