module Validator::Rules
  class Accepted < Rule
    # An array of accepted values
    @accepted : Array(String) = ["yes", "on", "1", "true"]

    # The error message template
    @error_message_template = "You must accept {{ label }}"

    # Validate the value
    def validate(value : _)
      @accepted.count(value) > 0
    end
  end
end
