require 'uri'
module Puppet::Parser::Functions

  # is_url? returns a boolean if the url is valid

  newfunction(:is_url_valid, :type => :rvalue) do |args|

    raise(Puppet::ParseError, "is_url_valid(): Wrong number of arguments " +
      "given (#{args.size} for 1)") if args.size < 1

    url = args[0]
    # this monkey patches the code inline at runtime and adds a new function
    String.class_eval do
      def is_valid_url?
        uri = URI.parse self
        value = uri.kind_of? URI::HTTP
      rescue URI::InvalidURIError
        value = false
      end
    end
    url.is_valid_url?
  end
end