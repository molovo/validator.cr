class Validator
  # The base class which all validation rules inherit
  abstract class Rule
    # The rule name
    @name : String?

    # The error message template
    @error_message_template : String?

    # The validator instance
    getter validator : Validator

    # The rule arguments
    getter args : Array(String)?

    # # Create the rule instance statically
    # def self.new(@validator : Validator, @args : Array(String) = [] of String) : self
    #   if responds_to? :initialize
    #     initialize validator, args
    #   end
    # end

    # Create the rule instance
    def initialize(@validator, @args = [] of String)
    end

    # The rule name
    def name : String
      if @name.nil?
        raise Errors::InvalidRuleError.new "You must specify a rule name"
      end

      @name
    end

    # The error message template
    def error_message(values : Hash(String, String)) : String
      template = @error_message_template

      if template.nil?
        raise Errors::InvalidRuleError.new "Rule #{@name} must specify a message template"
      end

      crinja = Crinja::Template.new template
      return crinja.render values
    end

    # Validate the provided value
    abstract def validate(value : _) : Boolean
  end
end
