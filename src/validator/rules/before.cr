module Validator::Rules
  class Before < Rule
    # The date to compare against
    @date : ::Time?

    # Whether the comparison should be inclusive
    @inclusive : Bool = false

    # The error message template
    @error_message_template = "The value for {{ label }} must be a valid date {% if inclusive == 'true' %}on or {% endif %}before {{ date }}"

    # Create the rule instance
    def initialize(@validator, @args = [] of String)
      args = @args
      if !args.nil?
        case args.size
        when 1 then @date = ::Time.parse args.first, "%F"
        when 2
          @date = ::Time.parse args.first, "%F"
          @inclusive = args[1] == "true" ? true : false
        end
      end

      if @date.nil?
        raise Errors::InvalidRuleError.new "You must define a date"
      end
    end

    # The error message template
    def error_message(values : Hash(String, String)) : String
      date = @date

      unless date.nil?
        values["date"] = date.to_s "%F"
      end

      values["inclusive"] = @inclusive.to_s

      super values
    end

    # Validate the value
    def validate(value : Validator::AllParamTypes) : Bool
      case value
      when .is_a? ::Time
        value_date = value
      when .is_a? String
        value_date = ::Time.parse value, "%F"
      when .is_a? Int32
        value_date = ::Time.parse value.to_s, "%s"
      end

      date = @date
      if value_date.nil? || date.nil?
        return false
      end

      if @inclusive
        return value_date <= date
      else
        return value_date < date
      end
    end
  end
end
