module GPhoto2
  class PortResult
    def self.as_string(rc)
      FFI::GPhoto2Port.gp_port_result_as_string(rc)
    end
  end
end
