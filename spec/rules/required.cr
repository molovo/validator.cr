describe Validator::Rules::Required do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["required"]
    instance = rule.new validator

    instance.is_a?(Validator::Rules::Required).should eq(true)
  end

  describe "#validate" do
    it "validates with a value" do
      validator = Validator.new
      rule = Validator::Rules::Required.new validator

      rule.validate("rainbows").should eq(true)
      rule.validate(1).should eq(true)
      rule.validate(["string"]).should eq(true)
      rule.validate({"string" => "string"}).should eq(true)
    end

    it "fails without a value" do
      validator = Validator.new
      rule = Validator::Rules::Required.new validator

      rule.validate(nil).should eq(false)
      rule.validate("").should eq(false)
      rule.validate(0).should eq(false)
      rule.validate([] of String).should eq(false)
      rule.validate({} of String => String).should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Required.new validator

      rule.error_message({"label" => "Name"}).should eq("Name is required")
    end
  end
end
