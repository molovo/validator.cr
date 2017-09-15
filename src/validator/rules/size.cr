module Validator::Rules
  class Size < Rule
    @value : Validator::AllParamTypes?

    # The size to compare to
    @size : Int32?

    # The error message template
    @error_message_template = "The value for {{ label }} must {{ message }}"

    def initialize(@validator, @args = [] of String)
      args = @args
      if !args.nil? && args.size === 1
        @size = args.first.to_i32
      end

      if @size.nil?
        raise Errors::InvalidRuleError.new "You must define a size"
      end
    end

    def error_message(values : Hash(String, String)) : String
      value = @value
      m = case value
          when value.nil?          then "be exactly #{@size.to_s}"
          when value.is_a?(Int)    then "be exactly #{@size.to_s}"
          when value.is_a?(Array)  then "contain exactly #{@size.to_s} items"
          when value.is_a?(Hash)   then "contain exactly #{@size.to_s} items"
          when value.is_a?(String) then "be exactly #{@size.to_s} characters long"
          else                          "be exactly #{@size.to_s}"
          end

      values["message"] = m
      super values
    end

    def validate(value : Validator::AllParamTypes) : Bool
      @value = value
      case value
      when .nil?          then return true
      when .is_a?(Array)  then return value.size == @size
      when .is_a?(Hash)   then return value.size == @size
      when .is_a?(String) then return value.size == @size
      when .is_a?(Int)    then return value == @size
      end

      false
    end
  end
end
