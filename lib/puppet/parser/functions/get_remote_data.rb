require 'uri'
require 'net/http'
require 'net/https'
require 'puppet/parser/functions'

module Puppet::Parser::Functions

  newfunction(:get_remote_data, :type => :rvalue) do |args|

    raise(Puppet::ParseError, "get_remote_data(): Wrong number of arguments " +
      "given (#{args.size} for 1)") if args.size < 1

    url = args[0]

    raise(Puppet::ParseError, "get_remote_data(): Invalid url given #{url}") if not function_is_url_valid([url])
    result = nil
    begin
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      case response.code
        when "200"
          result = response.body
        when "307"
          raise(response.code)
        else
          raise(Puppet::ParseError, "get_remote_data(): http error code: #{response.code}")
      end
    rescue Errno::ECONNREFUSED => e
      raise(Puppet::ParseError, "#{e.message}")
    rescue Exception => e
      if e.message == "307"
        # this is a redirect which we want to handle with an updated url
        url=response.header['location']
        retry
      end
      raise(Puppet::ParseError, "#{e.message}")
    end
    result
  end

end
