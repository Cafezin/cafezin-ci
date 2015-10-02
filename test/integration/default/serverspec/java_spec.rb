require_relative 'spec_helper'

describe command('java -version') do
  its(:stderr) { should include('1.7.') }
end
