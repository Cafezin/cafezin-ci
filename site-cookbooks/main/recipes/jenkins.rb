service "jenkins" do
  action :start
end

jenkins_plugin 'git' do
  version '2.4.0'
  notifies :restart, 'service[jenkins]', :immediately
end

xml = File.join(Chef::Config[:file_cache_path], 'config.xml')

template xml do
  source 'job_config.xml.erb'
end

jenkins_job 'Mobile' do
  config xml
end

jenkins_password_credentials 'jenkins' do
  id 'f2361e6b-b8e0-4b2b-890b-82e85bc1a59f'
  description 'Jenkins'
  password    'jenkins'
end

jenkins_ssh_slave 'macslave' do
  description 'Run test suites'
  remote_fs   '/Users/jenkins'
  labels      ['executor', 'freebsd', 'jail']

  host        node[:slave_ip]
  user        'jenkins'
  credentials 'jenkins'
  environment(
      PATH: '/usr/local/bin:/usr/bin',
      DELIVER_USER: node[:slave_apple_id],
      FASTLANE_USER: node[:slave_apple_id],
      FASTLANE_PASSWORD: node[:slave_apple_password],
      DELIVER_PASSWORD: node[:slave_apple_password],
      LANG: 'en_US.UTF-8',
      LANGUAGE: 'en_US.UTF-8',
      LC_ALL: 'en_US.UTF-8'
  )
end