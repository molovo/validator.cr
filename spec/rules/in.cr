describe Validator::Rules::In do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["in"]
    instance = rule.new validator, ["1", "2", "3"]

    instance.is_a?(Validator::Rules::In).should eq(true)
  end

  describe "#validate" do
    it "validates with accepted values" do
      validator = Validator.new
      rule = Validator::Rules::In.new validator, ["1", "2", "3"]

      rule.validate("1").should eq(true)
      rule.validate(1).should eq(true)
      rule.validate("2").should eq(true)
      rule.validate(2).should eq(true)
      rule.validate("3").should eq(true)
      rule.validate(3).should eq(true)
    end

    it "fails with non-accepted values" do
      validator = Validator.new
      rule = Validator::Rules::In.new validator, ["1", "2", "3"]

      rule.validate("rainbows").should eq(false)
      rule.validate(123).should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::In.new validator, ["1", "2", "3"]

      rule.error_message({"label" => "Name"}).should eq("Name must be one of 1, 2, 3")
    end
  end
end
