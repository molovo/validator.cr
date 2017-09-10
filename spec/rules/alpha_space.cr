describe Validator::Rules::AlphaSpace do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["alpha_space"]
    instance = rule.new validator

    instance.is_a?(Validator::Rules::AlphaSpace).should eq(true)
  end

  describe "#validate" do
    it "validates with a string of valid characters" do
      validator = Validator.new
      rule = Validator::Rules::AlphaSpace.new validator

      rule.validate("unicorn-1_2 3").should eq(true)
    end

    it "fails with invalid characters" do
      validator = Validator.new
      rule = Validator::Rules::AlphaSpace.new validator

      rule.validate("unicorns!").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::AlphaSpace.new validator

      rule.error_message({"label" => "Name"}).should eq("The value for Name must contain only letters, numbers, dashes, spaces and underscores")
    end
  end
end
