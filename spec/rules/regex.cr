describe Validator::Rules::Regex do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["regex"]
    instance = rule.new validator, ["^.+$"]

    instance.is_a?(Validator::Rules::Regex).should eq(true)
  end

  describe "#validate" do
    it "validates with a matching regex" do
      validator = Validator.new
      rule = Validator::Rules::Regex.new validator, ["^[a-z]+$"]

      rule.validate("unicorns").should eq(true)
    end

    it "fails with a non-matching regex" do
      validator = Validator.new
      rule = Validator::Rules::Regex.new validator, ["^[0-9]+$"]

      rule.validate("rainbows").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Regex.new validator, ["^[0-9]+$"]

      rule.error_message({"label" => "Name"}).should eq("The value for Name must match the regular expression /^[0-9]+$/")
    end
  end
end
