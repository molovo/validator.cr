describe Validator::Rules::Boolean do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["boolean"]
    instance = rule.new validator

    instance.is_a?(Validator::Rules::Boolean).should eq(true)
  end

  describe "#validate" do
    it "validates with boolean values" do
      validator = Validator.new
      rule = Validator::Rules::Boolean.new validator

      rule.validate("yes").should eq(true)
      rule.validate("no").should eq(true)
      rule.validate("on").should eq(true)
      rule.validate("off").should eq(true)
      rule.validate("1").should eq(true)
      rule.validate("0").should eq(true)
      rule.validate("true").should eq(true)
      rule.validate("false").should eq(true)
      rule.validate(true).should eq(true)
      rule.validate(false).should eq(true)
    end

    it "fails with non-boolean values" do
      validator = Validator.new
      rule = Validator::Rules::Boolean.new validator

      rule.validate("rainbows").should eq(false)
      rule.validate(123).should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Boolean.new validator

      rule.error_message({"label" => "Name"}).should eq("Name must be one of yes, no, true, false, 1, 0, on, off")
    end
  end
end
