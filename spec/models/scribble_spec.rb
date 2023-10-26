require "rails_helper"

RSpec.describe Scribble, type: :model do
  it "has a valid factory" do
    expect(build(:scribble)).to be_valid
  end

  it "must have some content" do
    scribble = build(:scribble, content: nil)
    expect(scribble).to_not be_valid
  end

  it "must not have content longer than 10000 characters" do
    scribble = build(:scribble, content: "a" * 10001)
    expect(scribble).to_not be_valid
  end

  it "can have content that is 10000 characters long" do
    scribble = build(:scribble, content: "a" * 10000)
    expect(scribble).to be_valid
  end
end
