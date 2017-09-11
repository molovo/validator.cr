module Validator::Rules
  class NotIn < Rule
    # An array of rejected values
    @rejected : ::Array(String)?

    # The error message template
    @error_message_template = "{{ label }} must not be one of {{ values }}"

    # Create the rule instance
    def initialize(@validator, @args = [] of String)
      args = @args
      if !args.nil? && args.size > 0
        @rejected = args
      end

      if @rejected.nil?
        raise Errors::InvalidRuleError.new "You must define a list of rejected values"
      end
    end

    # Render the error message template
    def error_message(values : Hash(String, String)) : String
      rejected = @rejected
      unless rejected.nil?
        values["values"] = rejected.join(", ")
      end

      super values
    end

    # Validate the value
    def validate(value : Validator::AllParamTypes) : Bool
      rejected = @rejected
      unless rejected.nil?
        return rejected.count(value.to_s) === 0
      end

      false
    end
  end
end
