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



  register_events {{
    "nanoconf:create" => params("presentation").desc("A nanoconf presentation was created"),
    "nanoconf:update" => params("presentation").desc("A nanoconf presentation was updated")
  }}

end
