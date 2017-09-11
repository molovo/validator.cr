require "./in"

module Validator::Rules
  class Boolean < In
    # An array of accepted values
    @accepted : ::Array(String)? = ["yes", "no", "true", "false", "1", "0", "on", "off"]
  end
end
