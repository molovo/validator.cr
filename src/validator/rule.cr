class Validator
  # The base class which all validation rules inherit
  class Rule
    # The rule name
    @name : String?

    # The error message template
    @error_message_template : String?

    # The validator instance
    getter validator : Validator

    # The rule arguments
    getter args : Array(String)

    # Create the rule instance statically
    def self.new(validator : Validator, args : Array(String) = [] of String) : self
      initialize validator, args
    end

    # Create the rule instance
    def initialize(@validator, @args = [] of String) : self
    end

    # The rule name
    def name : String
      unless @name.nil?
        @name
      end

      raise Errors::InvalidRuleError.new "You must specify a rule name"
    end

    # The error message template
    def error_message(values : Hash(String, String)) : String
      template = @error_message_template

      unless template.nil?
        crinja = Crinja::Template.new template
        return crinja.render values
      end

      raise Errors::InvalidRuleError.new "Rule #{@name} must specify a message template"
    end

    # Validate the provided value
    def validate(value : _) : Boolean
      raise Errors::InvalidRuleError.new "Rule #{@name} must specify it's own validate method"
    end
  end
end
