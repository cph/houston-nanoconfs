module Houston::Nanoconfs
  class Configuration

    def initialize
      @officer = "set the nanoconf officer email in your main.rb file "
    end

    def officer(*args)
      @officer = args.first.to_s if args.any?
      @officer
    end

  end
end
