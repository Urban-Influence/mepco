module Mepco
  class Config
    # Configuration options
    attr_accessor :username, :password, :token, :environment, :version

    # Initialize
    def initialize
      @environment = :development
      @version = 'v1.0'
    end
  end
end
