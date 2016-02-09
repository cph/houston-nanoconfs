require "houston/nanoconfs/engine"
require "houston/nanoconfs/configuration"

module Houston
  module Nanoconfs
    extend self

    def config(&block)
      @configuration ||= Nanoconfs::Configuration.new
      @configuration.instance_eval(&block) if block_given?
      @configuration
    end

  end
end
