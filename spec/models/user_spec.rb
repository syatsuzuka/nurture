require 'rails_helper'

RSpec.describe User, type: :model do
  #  -----Present validations-----
  it "is valid with valid attributes" do
    expect(build(:post)).to be_valid
  end

  it "is not valid without a first_name" do
    expect(build(:user, first_name: nil)).to_not be_valid
  end

  it "is not valid without a last_name" do
    expect(build(:user, last_name: nil)).to_not be_valid
  end

  #  -----Length validations-----
  it "is not valid if first_name has more than 60 characters" do
    expect(build(:user, first_name: 'x' * 61)).to_not be_valid
  end

  it "is not valid if last_name has more than 60 characters" do
    expect(build(:user, last_name: 'x' * 61)).to_not be_valid
  end

  it "is not valid if nickname has more than 60 characters" do
    expect(build(:user, nickname: 'x' * 61)).to_not be_valid
  end

  it "is not valid if email has more than 254 characters" do
    expect(build(:user, email: "#{'x' * 245}@gmail.com")).to_not be_valid
  end

  #  -----Uniqueness validations-----
end
