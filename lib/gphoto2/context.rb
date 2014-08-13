module GPhoto2
  class Context
    include FFI::GPhoto2
    include GPhoto2::Struct

    def initialize
      new
    end

    def finalize
      unref
    end
    alias_method :close, :finalize

    private

    def new
      ctx = gp_context_new()
      @ptr = GPContext.new(ctx)
    end

    def unref
      gp_context_unref(ptr)
    end
  end
end
