require 'spec_helper'
require 'json'

describe "get_remote_data function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  let(:data) do
    {'pint' => '16_oz_of_liquid_goodness'}
  end

  let(:url) do
    'http://www.google.com/ineedapint'
  end


  it "should exist" do
    Puppet::Parser::Functions.function("get_remote_data").should == "function_get_remote_data"
  end

  it "should raise a ParseError if there is less than 1 arguments" do
    lambda { scope.function_get_remote_data([]) }.should( raise_error(Puppet::ParseError))
  end

  it 'should return valid data' do
    json = data.to_json
    response = mock('Net::HTTPResponse')
    response.stubs(:code => '200', :message => "OK", :content_type => "text/json",
                   :body => json)
    Net::HTTP.stubs(:get_response).returns(response)
    scope.function_get_remote_data([url]).should eq(json)
  end

  it 'should return error with 400 response' do
    json = data.to_json
    response = mock('Net::HTTPResponse')
    response.stubs(:code => '400', :message => "OK", :content_type => "text/json",
                   :body => json)
    Net::HTTP.stubs(:get_response).returns(response)
    lambda { scope.function_get_remote_data([url])}.should ( raise_error(Puppet::ParseError, 'get_remote_data(): http error code: 400'))
  end



end