module Validator::Rules
  class Required < Rule
    # The error message template
    @error_message_template = "{{ label }} is required"

    # Validate the value
    def validate(value : Validator::AllParamTypes) : Bool
      case value
      when .nil?           then false
      when .is_a?(::Array) then (value.size != 0)
      when .is_a?(Hash)    then (value.size != 0)
      when .is_a?(String)  then (value != "")
      when .is_a?(Number)  then (value != 0)
      else                      true
      end
    end
  end
end
