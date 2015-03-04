require "rails_helper"

describe Task do

  before :each do
    @valid_attributes = {
      description: "I'm a new task",
      due_date: "04/04/2015"
    }
  end

  describe "validations" do
    it "is valid" do
      task = Task.new(@valid_attributes)
      expect(task.valid?).to eq true
    end

    it "is invalid without a description" do
      @valid_attributes.delete(:description)
      task = Task.new(@valid_attributes)

      expect(task.valid?).to eq false
      expect(task.errors[:description]).to eq ["can't be blank"]
    end
  end

end
