describe Validator::Rules::Alpha do
  it "can be sourced from validator" do
    validator = Validator.new
    rule = Validator::RULES["alpha"]
    instance = rule.new validator

    instance.is_a?(Validator::Rules::Alpha).should eq(true)
  end

  describe "#validate" do
    it "validates with a string of letters" do
      validator = Validator.new
      rule = Validator::Rules::Alpha.new validator

      rule.validate("unicorn").should eq(true)
    end

    it "fails with non-letter characters" do
      validator = Validator.new
      rule = Validator::Rules::Alpha.new validator

      rule.validate("123").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::Alpha.new validator

      rule.error_message({"label" => "Name"}).should eq("The value for Name must contain only letters")
    end
  end
end
