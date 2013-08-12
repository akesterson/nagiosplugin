
module NagiosPlugin
  class Range
    def initialize()
      @invert = false
      @rangestart = ''
      @rangeend = ''
    end

    def parse(spec='')
      # Parse the range
      if spec.start_with?('@')
        @invert = true
        spec = spec.slice(1..-1)
      end
      if spec.include?(':')
        @rangestart, @rangeend = spec.split(':')
      else
        @rangestart, @rangeend = '', spec
      end

      if @rangestart == '~'
        @rangestart = nil
      elsif @rangestart != ''
        if @rangestart.include?('.')
          @rangestart = @rangestart.to_f
        else
          @rangestart = @rangestart.to_i
        end
      else
        raise TypeError, "range start must be one of [0-9~], not #{@rangestart}"
      end

      if @rangeend != nil and @rangeend != ''
        if @rangeend.include?('.')
          @rangeend = @rangeend.to_f
        else
          @rangeend = @rangeend.to_i
        end
      elsif @rangeend
        raise TypeError, "range ends must be one of [0-9~], not #{rangeend}"
      end

      verify()
      return [@invert, @rangestart, @rangeend]
    end

    def verify()
      # Raise an exception if the range isn't consistent
      if ( @rangestart != nil and @rangeend != nil and @rangestart > @rangeend)
        raise Exception, "range start #{@rangestart} must not be greater than end #{@rangeend}"
      end
    end

    def match(value)
      retval = false
      # Return true if value is within the bounds of the range
      if @invert
        if @rangestart == nil or value >= @rangestart
          if @rangeend == nil or value <= @rangeend
            return true
          end
        end
      else
        if (@rangestart == nil or value < @rangestart) or (@rangeend == nil or value > @rangeend)
          return true
        end
      end
      return false
    end
  end
end
