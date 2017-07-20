require "json"
require "crinja"
require "./validator/*"
require "./validator/errors/*"
require "./validator/rules/*"

# The main validator instance
class Validator
  RULES = {
    "alpha" => Rules::Alpha,
    "regex" => Rules::Regex,
  }

  # Whether the current dataset is valid
  @valid : Bool? = nil

  # A hash of errors found during validation
  getter errors = {} of String => String

  # The data to be validated
  getter data = {} of String => JSON::Any

  # A hash of rules to be used
  getter rules = {} of String => Array(Rule)

  # A hash of custom error messages
  property messages = {} of String => String

  # A hash of custom field labels
  property labels = {} of String => String

  # Create the validator instance
  def initialize(@data : Hash(String, JSON::Any) = {} of String => JSON::Any, rules : Hash(String, String) = {} of String => String)
    parse rules
  end

  # Validate the provided data
  def validate : Bool
    # Reset the errors
    @errors = {} of String => String

    @data.each_with_index do |name, value|
      unless @rules.has_key? name
        next
      end

      @rules[name].each do |rule|
        if !rule.validate value
          if @messages.has_key? name
            @errors[name] = @messages[name]
            break
          end

          label = name
          if @labels.has_key? name
            label = @labels[name]
          end

          @errors[name] = rule.message({
            "name":  name,
            "label": label,
          })
          break
        end
      end
    end

    @valid = @errors.size > 0

    valid?
  end

  def valid? : Bool
    if @valid.nil?
      validate
    end

    @valid
  end

  # Parse a rule string and create the corresponding rule instance
  private def parse(rules : Hash(String, String))
    rules.map do |name, rules|
      rules.split('|').map do |rule|
        # Separate the rule name and arguments
        name, args = rule.split ':'

        # If there are arguments present, separate them into an array
        unless args.nil?
          args = args.split ','
        end

        # Check the rule name is valid
        unless RULES.has_key? name
          raise Errors::InvalidRuleError.new "Rule #{name} does not exist"
        end

        # Create the rule instance
        rule = RULES[name]
        rule.new self, args
      end
    end
  end
end
