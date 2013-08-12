module GPhoto2
  class Context
    include FFI::GPhoto2

    attr_reader :ptr

    def initialize
      ctx = new
      @ptr = GPContext.new(ctx)
    end

    def to_ptr
      @ptr
    end

    private

    def new
      gp_context_new()
    end
  end
end
