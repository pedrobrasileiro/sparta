require 'spec_helper'

describe Ticket do
  it "should have associations" do
    should have_many(:comments).dependent(:destroy)
    should belong_to(:project)
    should belong_to(:status)    
    should belong_to(:type)    
    should belong_to(:assigned_to)    
    should belong_to(:reporter)    
  end
end
