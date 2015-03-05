require "rails_helper"

describe User do

  before :each do
    @valid_attributes = {
      first_name: "Charlie",
      last_name: "Chaplin",
      email: "charliechaplin@example.com",
      password: "password",
      password_confirmation: "password"
    }
  end

  describe "validations" do

    it "is valid" do
      user = User.new(@valid_attributes)
      expect(user.valid?).to eq true
    end

    it "is invalid without a first name" do
      @valid_attributes.delete(:first_name)
      user = User.new(@valid_attributes)
      expect(user.valid?).to eq false
      expect(user.errors[:first_name]).to eq ["can't be blank"]
    end

    it "is invalid without a last name" do
      @valid_attributes.delete(:last_name)
      user = User.new(@valid_attributes)
      expect(user.valid?).to eq false
      expect(user.errors[:last_name]).to eq ["can't be blank"]
    end

    it "is invalid without an email" do
      @valid_attributes.delete(:email)
      user = User.new(@valid_attributes)
      expect(user.valid?).to eq false
      expect(user.errors[:email]).to eq ["can't be blank"]
    end

    it "is invalid without a password" do
      @valid_attributes.delete(:password)
      user = User.new(@valid_attributes)
      expect(user.valid?).to eq false
      expect(user.errors[:password]).to eq ["can't be blank"]
    end

    it "is invalid without a password confirmation" do
      @valid_attributes[:password_confirmation] = "notpassword"
      user = User.new(@valid_attributes)
      expect(user.valid?).to eq false
      expect(user.errors[:password_confirmation]).to eq ["doesn't match Password"]
    end

  end

end
