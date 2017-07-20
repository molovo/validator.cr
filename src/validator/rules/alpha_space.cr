require "./regex"

module Validator::Rules
  class AlphaSpace < Regex
    # The regular expression to validate against
    @regex = /^[a-zA-Z0-9- _]+$/

    # The error message template
    @error_message_template = "The value for {{ label }} must contain only letters, numbers, dashes, spaces and underscores"
  end
end
