describe Validator::Rules::Max do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["max"]
    instance = rule.new validator, ["8"]

    instance.is_a?(Validator::Rules::Max).should eq(true)
  end

  describe "#validate" do
    it "validates with a value" do
      validator = Validator.new
      rule = Validator::Rules::Max.new validator, ["8"]

      rule.validate("rainbows").should eq(true)
      rule.validate(8).should eq(true)
      rule.validate("test").should eq(true)
      rule.validate(4).should eq(true)
    end

    it "does not fail for nil" do
      validator = Validator.new
      rule = Validator::Rules::Max.new validator, ["8"]

      rule.validate(nil).should eq(true)
    end

    it "fails with incorrect value" do
      validator = Validator.new
      rule = Validator::Rules::Max.new validator, ["8"]

      rule.validate("something longer").should eq(false)
      rule.validate(16).should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Max.new validator, ["8"]

      rule.error_message({"label" => "Name"}).should eq("The value for Name must be at most 8")
    end
  end
end
