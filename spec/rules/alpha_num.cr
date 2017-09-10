describe Validator::Rules::AlphaNum do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["alpha_num"]
    instance = rule.new validator

    instance.is_a?(Validator::Rules::AlphaNum).should eq(true)
  end

  describe "#validate" do
    it "validates with a string of alphanumeric characters" do
      validator = Validator.new
      rule = Validator::Rules::AlphaNum.new validator

      rule.validate("unicorn123").should eq(true)
    end

    it "fails with non-letter characters" do
      validator = Validator.new
      rule = Validator::Rules::AlphaNum.new validator

      rule.validate("unicorns!").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::AlphaNum.new validator

      rule.error_message({"label" => "Name"}).should eq("The value for Name must contain only letters and numbers")
    end
  end
end
