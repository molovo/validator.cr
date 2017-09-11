describe Validator::Rules::NotIn do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["not_in"]
    instance = rule.new validator, ["1", "2", "3"]

    instance.is_a?(Validator::Rules::NotIn).should eq(true)
  end

  describe "#validate" do
    it "validates with non-rejected values" do
      validator = Validator.new
      rule = Validator::Rules::NotIn.new validator, ["1", "2", "3"]

      rule.validate("rainbows").should eq(true)
      rule.validate(123).should eq(true)
    end

    it "fails with rejected values" do
      validator = Validator.new
      rule = Validator::Rules::NotIn.new validator, ["1", "2", "3"]

      rule.validate("1").should eq(false)
      rule.validate(1).should eq(false)
      rule.validate("2").should eq(false)
      rule.validate(2).should eq(false)
      rule.validate("3").should eq(false)
      rule.validate(3).should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::NotIn.new validator, ["1", "2", "3"]

      rule.error_message({"label" => "Name"}).should eq("Name must not be one of 1, 2, 3")
    end
  end
end
