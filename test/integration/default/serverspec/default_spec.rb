require 'spec_helper'

describe 'exhibitor::default' do
  describe port '8080' do
    it { should be_listening.with('tcp6') }
  end

  describe service 'exhibitor' do
    it { should be_running }
  end
end
