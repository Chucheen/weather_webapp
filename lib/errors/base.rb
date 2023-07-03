module Errors
  class Base < StandardError
    include Formatter
    attr_reader :source

    def initialize(message, source = nil)
      @source = source || :unknown
      super(message)
    end

    def to_h
      to_error(message, source)
    end
  end
end