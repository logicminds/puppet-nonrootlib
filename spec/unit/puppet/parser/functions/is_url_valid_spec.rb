require 'spec_helper'

describe "is_url_valid function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("is_url_valid").should == "function_is_url_valid"
  end

  it "should raise a ParseError if there is less than 1 arguments" do
    lambda { scope.function_is_url_valid([]) }.should( raise_error(Puppet::ParseError))
  end

  context 'bad url' do
    let(:url) do
      'htt://www.google.com'
    end
    it 'should return false' do
      scope.function_is_url_valid([url]).should be_false
    end

  end

  context 'good url' do
    let(:url) do
      'http://www.google.com'
    end
    it 'should return true ' do
      scope.function_is_url_valid([url]).should be_true
    end

  end



end