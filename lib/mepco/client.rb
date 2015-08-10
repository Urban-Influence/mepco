require 'net/http'
require 'net/https'
require 'base64'
require 'mepco/endpoint'

module Mepco
  class Client
    attr_reader :config

    # Initialize the Mepco client
    #
    # @param [Config]
    def initialize(config)
      @config = config
      @endpoint = Endpoint.new(@config.environment, @config.version)
    end

    # Get the SSO URL
    #
    # @param [String] Account #
    # @return [String]
    def sso_url(account_number)
      post("GenerateSSOURL", account_number).body
    end

    protected

    # Perform post request
    #
    # @param [String] Requested path
    # @param [String] Query
    def post(path, query = {})
      uri = URI(@endpoint.for(path))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      auth_code = Base64.encode64([
        config.username,
        config.password
      ].join(':'))

      headers = {
        'Authorization' => "Basic #{auth_code}",
        'AuthToken' => config.token
      }

      http.post(@endpoint.for(path), query, headers)
    end
  end
end
