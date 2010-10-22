require 'spec_helper'

describe Comment do
  it "should have associations" do
    should belong_to(:ticket)
    should belong_to(:user)
  end
end
