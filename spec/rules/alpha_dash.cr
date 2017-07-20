describe Validator::Rules::AlphaDash do
  describe "#validate" do
    it "validates with a string of letters, numbers and dashes" do
      validator = Validator.new
      rule = Validator::Rules::AlphaDash.new validator

      rule.validate("unicorn-123").should eq(true)
    end

    it "fails with invalid characters" do
      validator = Validator.new
      rule = Validator::Rules::AlphaDash.new validator

      rule.validate("unicorns!").should eq(false)
    end
  end

  describe "#error_message" do
    it "provides an error message" do
      validator = Validator.new
      rule = Validator::Rules::AlphaDash.new validator

      rule.error_message({"label" => "Name"}).should eq("The value for Name must contain only letters, numbers and dashes")
    end
  end
end
