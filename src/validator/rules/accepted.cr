require "./in"

module Validator::Rules
  class Accepted < In
    # An array of accepted values
    @accepted : ::Array(String)? = ["yes", "on", "1", "true"]

    # The error message template
    @error_message_template = "You must accept {{ label }}"
  end
end
