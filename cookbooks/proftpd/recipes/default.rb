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
  
  directory '/etc/portage/package.use' do
    owner   'root'
    group   'root'
    mode    '0755'
    action  :create
    not_if  'test -d /etc/portage/package.use'
  end

  remote_file '/etc/portage/package.use/proftpd' do
    owner   'root'
    group   'root'
    mode    '0755'
    source  'package.use.proftpd'
    backup  false
    action  :create
  end
  
  package 'proftpd' do
    action :install
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
    supports :start => true, :stop => true, :restart => true, :reload => true
    action [:enable, :restart]
  end
  
end