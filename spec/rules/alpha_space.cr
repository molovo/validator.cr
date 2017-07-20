describe Validator::Rules::AlphaSpace do
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
