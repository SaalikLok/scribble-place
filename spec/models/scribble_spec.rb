require "rails_helper"

RSpec.describe Scribble, type: :model do
  it "has a valid factory" do
    expect(build(:scribble)).to be_valid
  end

  it "must have some content" do
    scribble = build(:scribble, content: nil)
    expect(scribble).to_not be_valid
  end
end
