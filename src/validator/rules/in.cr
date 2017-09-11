module Validator::Rules
  class In < Rule
    # An array of accepted values
    @accepted : ::Array(String)?

    # The error message template
    @error_message_template = "{{ label }} must be one of {{ values }}"

    # Create the rule instance
    def initialize(@validator, @args = [] of String)
      args = @args
      if !args.nil? && args.size > 0
        @accepted = args
      end

      if @accepted.nil?
        raise Errors::InvalidRuleError.new "You must define a list of accepted values"
      end
    end

    # Render the error message template
    def error_message(values : Hash(String, String)) : String
      accepted = @accepted
      unless accepted.nil?
        values["values"] = accepted.join(", ")
      end

      super values
    end

    # Validate the value
    def validate(value : Validator::AllParamTypes) : Bool
      accepted = @accepted
      unless accepted.nil?
        return accepted.count(value.to_s) > 0
      end

      false
    end
  end
end
