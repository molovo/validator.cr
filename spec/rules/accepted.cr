describe Validator::Rules::Accepted do
  describe "#validate" do
    it "validates with accepted values" do
      validator = Validator.new
      rule = Validator::Rules::Accepted.new validator

      rule.validate("yes").should eq(true)
      rule.validate("on").should eq(true)
      rule.validate("1").should eq(true)
      rule.validate("true").should eq(true)
    end

    it "fails with non-truthy values" do
      validator = Validator.new
      rule = Validator::Rules::Accepted.new validator

      rule.validate("no").should eq(false)
      rule.validate("off").should eq(false)
      rule.validate("0").should eq(false)
      rule.validate("false").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Accepted.new validator

      rule.error_message({"label" => "Name"}).should eq("You must accept Name")
    end
  end
end
