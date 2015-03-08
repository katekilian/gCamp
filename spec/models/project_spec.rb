require 'rails_helper'

describe Project do

  before :each do
    @valid_attributes = {
      name: "I'm a new project"
    }
  end

  describe "validations" do

    it "is valid" do
      project = Project.new(@valid_attributes)
      expect(project.valid?).to eq true
    end

    it "is invalid without a name" do
      @valid_attributes.delete(:name)
      project = Project.new(@valid_attributes)

      expect(project.valid?).to eq false
      expect(project.errors[:name]).to eq ["can't be blank"]
    end

  end

end
