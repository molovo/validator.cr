require "./regex"

module Validator::Rules
  class Alpha < Regex
    # The regular expression to validate against
    @regex = /^[a-zA-Z]+$/

    # The error message template
    @error_message_template = "The value for {{ label }} must contain only letters"
  end
end
