require "./regex"

module Validator::Rules
  class AlphaDash < Regex
    # The regular expression to validate against
    @regex = /^[a-zA-Z0-9-]+$/

    # The error message template
    @error_message_template = "The value for {{ label }} must contain only letters, numbers and dashes"
  end
end
