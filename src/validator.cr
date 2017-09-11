require "json"
require "crinja"
require "http/params"
require "./validator/*"
require "./validator/errors/*"
require "./validator/rules/*"

# The main validator instance
class Validator
  RULES = {
    "accepted"    => Rules::Accepted,
    "after"       => Rules::After,
    "alpha_dash"  => Rules::AlphaDash,
    "alpha_num"   => Rules::AlphaNum,
    "alpha_space" => Rules::AlphaSpace,
    "alpha"       => Rules::Alpha,
    "array"       => Rules::Array,
    "before"      => Rules::Before,
    "boolean"     => Rules::Boolean,
    "in"          => Rules::In,
    "not_in"      => Rules::NotIn,
    "regex"       => Rules::Regex,
    "required"    => Rules::Required,
  }

  # Whether the current dataset is valid
  @valid : Bool? = nil

  # A hash of rules to be used
  @rules = {} of String => Array(Rule)

  # A hash of rules to be used
  @rules = {} of String => Array(Rule)

  # A hash of rules to be used
  @rules = {} of String => Array(Rule)

  # A hash of errors found during validation
  getter errors = {} of String => String

  # The data to be validated
  getter data = {} of String => AllParamTypes

  # A hash of custom error messages
  property messages = {} of String => String

  # A hash of custom field labels
  property labels = {} of String => String

  # Union of all Int and Float types, since Number cannot be used in unions
  alias AllNumberTypes = Int16 | Int32 | Int64 | Int8 | UInt16 | UInt32 | UInt64 | UInt8 | Float32 | Float64

  # Alias of all possible parameter types which could be used for values
  alias AllParamTypes = JSON::Type | AllNumberTypes | Hash(String, AllParamTypes) | Array(AllParamTypes) | Time

  # Create the validator instance
  def initialize(data : Kemal::ParamParser, rules : Hash(String, String) = {} of String => String)
    typed_data = {} of String => AllParamTypes

    data.all.each do |key, value|
      typed_data[key] = value.as(AllParamTypes)
    end

    @data = typed_data

    parse rules
  end

  # Create the validator instance
  def initialize(data : HTTP::Params, rules : Hash(String, String) = {} of String => String)
    typed_data = {} of String => AllParamTypes

    data.each do |key, value|
      typed_data[key] = value.as(AllParamTypes)
    end

    @data = typed_data

    parse rules
  end

  # Create the validator instance
  def initialize(@data : Hash(String, AllParamTypes) = {} of String => AllParamTypes, rules : Hash(String, String) = {} of String => String)
    parse rules
  end

  # Validate the provided data
  def validate : Bool
    # Reset the errors
    @errors = {} of String => String

    @rules.each do |name, rules|
      value = nil
      if @data.has_key? name
        value = @data[name]
      end

      rules.each do |rule|
        if rule.validate value
          next
        end

        if @messages.has_key? name
          @errors[name] = @messages[name]
          break
        end

        label = name.titleize
        if @labels.has_key? name
          label = @labels[name]
        end

        @errors[name] = rule.error_message({
          "name"  => name.as(String),
          "label" => label.as(String),
        })

        break
      end
    end

    puts @errors.size
    if @errors.size > 0
      @valid = false
    else
      @valid = true
    end

    valid?
  end

  def valid? : Bool
    if @valid.nil?
      validate
    end

    @valid.as(Bool)
  end

  # Parse a rule string and create the corresponding rule instance
  private def parse(ruleset : Hash(String, String))
    ruleset.each do |name, rules|
      @rules[name] = rules.split('|').map do |rule|
        # Separate the rule name and arguments
        args = rule.split ':'
        name = args.shift
        args ||= [] of String

        # If there are arguments present, separate them into an array
        if args.first?
          args = args.first.split ','
        end

        # Check the rule name is valid
        unless RULES.has_key? name
          raise Errors::InvalidRuleError.new "Rule #{name} does not exist"
        end

        # Create the rule instance
        rule = RULES[name]
        rule.new(self, args)
      end
    end
  end
end
