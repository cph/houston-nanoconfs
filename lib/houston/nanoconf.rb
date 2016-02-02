require "houston/nanoconf/engine"
require "houston/nanoconf/configuration"

module Houston
  module Nanoconf
    extend self

    def config(&block)
      @configuration ||= Nanoconf::Configuration.new
      @configuration.instance_eval(&block) if block_given?
      @configuration
    end

  end
end
