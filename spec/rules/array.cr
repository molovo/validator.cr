describe Validator::Rules::Array do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["array"]
    instance = rule.new validator

    instance.is_a?(Validator::Rules::Array).should eq(true)
  end

  describe "#validate" do
    it "validates with a value" do
      validator = Validator.new
      rule = Validator::Rules::Array.new validator

      rule.validate(["rainbows", "unicorns"]).should eq(true)
      rule.validate([1, 2]).should eq(true)
      rule.validate([] of String).should eq(true)
    end

    it "fails without a value" do
      validator = Validator.new
      rule = Validator::Rules::Array.new validator

      rule.validate(nil).should eq(false)
      rule.validate("rainbows").should eq(false)
      rule.validate(123).should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Array.new validator

      rule.error_message({"label" => "Name"}).should eq("Name must be an array")
    end
  end
end
