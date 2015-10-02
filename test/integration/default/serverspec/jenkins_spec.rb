require_relative 'spec_helper'

describe package "jenkins" do
  it { should be_installed }
end

describe service "jenkins" do
  it { should be_running }
end

#nodes
describe file('/var/lib/jenkins/nodes/macslave') do
  it { should exist }
  it { should be_owned_by 'jenkins' }
  it { should be_directory }
end

describe file('/var/lib/jenkins/nodes/macslave/config.xml') do
  it { should exist }
  it { should contain '<remoteFS>/Users/jenkins</remoteFS>' }
  it { should be_owned_by 'jenkins' }
end

# job
describe port(8080) do
  it { should be_listening.with('tcp6') }
end

describe file('/var/lib/jenkins/jobs/Mobile') do
  it { should exist }
  it { should be_owned_by 'jenkins' }
  it { should be_directory }
end

describe file('/var/lib/jenkins/jobs/Mobile/config.xml') do
  it { should exist }
  it { should contain 'hudson.plugins.git.GitSCM' }
  it { should contain 'hudson.triggers.SCMTrigger' }
  it { should contain 'CODE_SIGN_IDENTITY'}
  it { should contain 'CODE_SIGNING_REQUIRED=NO'}
  it { should contain '<assignedNode>macslave</assignedNode>' }
  it { should be_owned_by 'jenkins' }
end
