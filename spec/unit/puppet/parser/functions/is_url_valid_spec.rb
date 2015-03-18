require 'spec_helper'

describe "is_url_valid function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    expect(Puppet::Parser::Functions.function("is_url_valid")).to eq("function_is_url_valid")
  end

  it "should raise a ParseError if there is less than 1 arguments" do
    expect { scope.function_is_url_valid([]) }.to( raise_error(Puppet::ParseError))
  end

  context 'bad url' do
    let(:url) do
      'htt://www.google.com'
    end
    it 'should return false' do
      expect(scope.function_is_url_valid([url])).to be_falsey
    end

  end

  context 'good url' do
    let(:url) do
      'http://www.google.com'
    end
    it 'should return true ' do
      expect(scope.function_is_url_valid([url])).to be_truthy
    end

  end



end