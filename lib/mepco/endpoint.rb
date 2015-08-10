module Mepco
  class Endpoint
    attr_reader :environment, :version

    # Initialize the endpoint
    #
    # @param [Boolean]
    def initialize(environment, version)
      @environment = environment
      @version = version
    end

    # Get full URL for path
    #
    # @param [String] Path
    # @return [String]
    def for(path)
      [endpoint, version, path].join('/')
    end

    # A hash of endpoints by environment
    #
    # @return [Hash]
    def endpoints
      @urls ||= {
        development: 'https://sandbox.api.mepco.com',
        production: 'https://api.mepco.com'
      }
    end

    # Get the endpoint for given environment
    #
    # @return [String]
    def endpoint
      endpoints.fetch(environment)
    end
  end
end
