require_relative 'spec_helper'

shared_examples_for 'exhibitor' do
  describe port '8080' do
    it { should be_listening }
  end
end
