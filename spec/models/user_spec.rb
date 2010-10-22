require 'spec_helper'

describe User do
  it "should have associations" do
    # should have_and_belongs_to_many(:projects)
    should have_many(:comments)
  end  
end
