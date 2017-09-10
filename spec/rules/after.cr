describe Validator::Rules::After do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["after"]
    instance = rule.new validator, ["2010-01-01"]

    instance.is_a?(Validator::Rules::After).should eq(true)
  end

  describe "#validate" do
    it "validates with a correct date" do
      validator = Validator.new
      rule = Validator::Rules::After.new validator, ["2010-01-01"]

      rule.validate("2015-01-01").should eq(true)
    end

    it "fails with an incorrect date" do
      validator = Validator.new
      rule = Validator::Rules::After.new validator, ["2010-01-01"]

      rule.validate("2001-01-01").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::After.new validator, ["2010-01-01"]

      rule.error_message({"label" => "Name"}).should eq("The value for Name must be a valid date after 2010-01-01")
    end
  end
end
