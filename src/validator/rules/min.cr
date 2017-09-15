require "./size"

module Validator::Rules
  class Min < Size
    # The error message template
    @error_message_template = "The value for {{ label }} must {{ message }}"

    def error_message(values : Hash(String, String)) : String
      value = @value
      m = case value
          when value.nil?          then "be at least #{@size.to_s}"
          when value.is_a?(Int)    then "be at least #{@size.to_s}"
          when value.is_a?(Array)  then "contain at least #{@size.to_s} items"
          when value.is_a?(Hash)   then "contain at least #{@size.to_s} items"
          when value.is_a?(String) then "be at least #{@size.to_s} characters long"
          else                          "be at least #{@size.to_s}"
          end

      values["message"] = m
      super values
    end

    def validate(value : Validator::AllParamTypes) : Bool
      @value = value
      size = @size

      unless size.nil?
        case value
        when .nil?          then return true
        when .is_a?(Array)  then return value.size >= size
        when .is_a?(Hash)   then return value.size >= size
        when .is_a?(String) then return value.size >= size
        when .is_a?(Int)    then return value >= size
        end
      end

      false
    end
  end
end
