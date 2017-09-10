module Validator::Rules
  class Regex < Rule
    # The regular expression to validate against
    @regex : ::Regex?

    # The error message template
    @error_message_template = "The value for {{ label }} must match the regular expression {{ regex }}"

    # Create the rule instance
    def initialize(@validator, @args = [] of String)
      args = @args
      if !args.nil? && args.size === 1
        @regex = ::Regex.new args.first
      end

      if @regex.nil?
        raise Errors::InvalidRuleError.new "You must define a regular expression"
      end
    end

    # The error message template
    def error_message(values : Hash(String, String)) : String
      values["regex"] = @regex.inspect
      super values
    end

    # Validate the provided value
    def validate(value : Validator::AllParamTypes) : Bool
      !(@regex !~ value)
    end
  end
end
