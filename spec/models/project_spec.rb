require 'spec_helper'

describe Project do
  it "should associated with" do
    should have_many(:tickets).dependent(:destroy)
    should have_many(:ticket_statuses).dependent(:destroy)
    should have_many(:ticket_types).dependent(:destroy)    
    should belong_to(:default_status) # in future change to 'have_one'
    should validate_presence_of(:name)    
  end
end
