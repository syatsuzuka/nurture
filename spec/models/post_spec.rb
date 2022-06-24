require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is valid with valid attributes" do
    expect(Post.new(user: sample_student)).to be_valid
  end

  it "is not valid without a title"
  it "is not valid without a content"
  it "is not valid without a user"
  it "is not valid without a start_date"
  it "is not valid without a start_date"

end
