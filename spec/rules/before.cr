describe Validator::Rules::Before do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["before"]
    instance = rule.new validator, ["2010-01-01"]

    instance.is_a?(Validator::Rules::Before).should eq(true)
  end

  describe "#validate" do
    it "validates with a correct date" do
      validator = Validator.new
      rule = Validator::Rules::Before.new validator, ["2010-01-01"]

      rule.validate("2009-01-01").should eq(true)
    end

    it "fails with an incorrect date" do
      validator = Validator.new
      rule = Validator::Rules::Before.new validator, ["2010-01-01"]

      rule.validate("2011-01-01").should eq(false)
    end

    it "validates with matching date when inclusive == true" do
      validator = Validator.new
      rule = Validator::Rules::Before.new validator, ["2010-01-01", "true"]

      rule.validate("2010-01-01").should eq(true)
    end

    it "fails with matching date when inclusive == false" do
      validator = Validator.new
      rule = Validator::Rules::Before.new validator, ["2010-01-01"]

      rule.validate("2010-01-01").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Before.new validator, ["2010-01-01"]

      rule.error_message({"label" => "Name"}).should eq("The value for Name must be a valid date before 2010-01-01")
    end

    it "provides a different error message when inclusive == true" do
      validator = Validator.new
      rule = Validator::Rules::Before.new validator, ["2010-01-01", "true"]

      rule.error_message({"label" => "Name"}).should eq("The value for Name must be a valid date on or before 2010-01-01")
    end
  end
end
