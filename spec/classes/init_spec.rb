require 'spec_helper'
describe 'varnish' do

  context 'with defaults for all parameters' do
    it { should contain_class('varnish') }
  end
end
