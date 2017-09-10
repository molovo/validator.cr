module Validator::Rules
  class Array < Rule
    # The error message template
    @error_message_template = "{{ label }} must be an array"

    # Validate the value
    def validate(value : Validator::AllParamTypes) : Bool
      value.is_a?(::Array)
    end
  end
end
