module Validator::Rules
  class After < Rule
    # The date to compare against
    @date : ::Time?

    # The error message template
    @error_message_template = "The value for {{ label }} must be a valid date after {{ date }}"

    # Create the rule instance
    def initialize(@validator, @args = [] of String)
      args = @args
      if !args.nil? && args.size === 1
        @date = ::Time.parse args.first, "%F"
      end

      if @date.nil?
        raise Errors::InvalidRuleError.new "You must define a date"
      end
    end
    
    # The error message template
    def error_message(values : Hash(String, String)) : String
      date = @date
      
      unless date.nil?
        values["date"] = date.to_s "%F"
      end

      super values
    end

    def validate(value : _) : Bool
      case value
      when .is_a? ::Time
        value_date = value
      when .is_a? String
        value_date = ::Time.parse value, "%F"
      when .is_a? Int32
        value_date = ::Time.parse value, "%s"
      end

      date = @date
      if value_date.nil? || date.nil?
        return false
      end

      value_date > date
    end
  end
end
