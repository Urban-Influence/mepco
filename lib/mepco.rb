require "mepco/version"
require "mepco/config"
require "mepco/client"

module Mepco
  # Define our accessor
  class << self
    attr_accessor :config
  end

  # Get a Configuration object
  #
  # @return [Configuration]
  def self.config
    @config ||= Config.new
  end

  # Configure Mepco
  #
  # @param [Proc]
  def self.configure(&block)
    yield config
  end
end
