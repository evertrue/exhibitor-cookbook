require 'spec_helper'

describe 'exhibitor::default' do
  it_behaves_like 'exhibitor'

  describe service 'exhibitor' do
    it { should be_running }
  end
end
