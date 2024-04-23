nginx_path          = input('nginx_path', value: '/etc/nginx', description: 'Default nginx configurations path')
nginx_conf          = File.join(nginx_path, 'nginx.conf')
nginx_confd         = File.join(nginx_path, 'conf.d')

control 'nginx-port' do
  impact 1.0
  title 'Test nginx version'
  desc 'Check if nginx version is installed'
  describe nginx do
    its('version') { should eq '1.22.1' }
  end
end

control 'nginx-02' do
  impact 1.0
  title 'Test nginx version'
  desc 'The NGINX config file should owned by root, only be writable by owner and not write- and readable by others.'
  describe file(nginx_conf) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end

control 'nginx-03' do
  impact 1.0
  title 'Test nginx version'
  desc 'Remove the default nginx config files.'
  describe file(File.join(nginx_confd, 'default.conf')) do
    it { should_not be_file }
  end
end
