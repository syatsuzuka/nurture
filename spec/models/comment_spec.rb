require 'rails_helper'

RSpec.describe Comment, type: :model do
  #  -----Present validations-----
  it "is valid with valid attributes" do
    expect(build(:comment)).to be_valid
  end

  it "is not valid without a content" do
    expect(build(:comment, content: nil)).to_not be_valid
  end

  it "is not valid without a user" do
    expect(build(:post, user: nil)).to_not be_valid
  end

  it "is not valid without a post" do
    expect(build(:comment, post: nil)).to_not be_valid
  end
  #  -----Length validations-----
  it "is not valid with a content over 70 characters" do
    expect(build(:comment, content: 'x' * 71)).to_not be_valid
  end

  it "is not valid with a content less than 6 characters" do
    expect(build(:comment, content: 'x' * 5)).to_not be_valid
  end
end
