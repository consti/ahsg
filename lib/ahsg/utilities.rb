module Ahsg
  module Utilities
    def self.arg_to_range(arg)
      arg = arg.new(arg, arg) unless arg.is_a?(Range)
      r_begin = arg.first
      r_end   = arg.end
      if r_begin.is_a?(Integer)
        r_begin = Date.new(r_begin)
        r_end   = Date.new(r_end)
      end
      r_begin.beginning_of_year..r_end.end_of_year
    end
  end
end
