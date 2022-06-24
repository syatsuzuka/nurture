require 'rails_helper'

RSpec.describe Post, type: :model do
    #  -----Present validations-----
  it "is valid with valid attributes" do
    expect(build(:post)).to be_valid
  end

  it "is not valid without a title" do
    expect(build(:post, title: nil)).to_not be_valid
  end

  it "is not valid without a content" do
    expect(build(:post, content: nil)).to_not be_valid
  end

  it "is not valid without a user" do
    expect(build(:post, user: nil)).to_not be_valid
  end
  #  -----Length validations-----
  it "is not valid with a title over 70 characters" do
    expect(build(:post, title: 'x' * 71)).to_not be_valid
  end

  it "is not valid with a title less than 6 characters" do
    expect(build(:post, title: 'x' * 5)).to_not be_valid
  end

  it "is not valid with a content less than 30 characters" do
    expect(build(:post, title: 'x' * 28)).to_not be_valid
  end

  it "is not valid with a content over 3000 characters" do
    expect(build(:post, title: 'x' * 3002)).to_not be_valid
  end
  #  -----Uniqueness validations-----


end
