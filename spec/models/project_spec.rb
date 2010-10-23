require 'spec_helper'

describe Project do
  it "should have associations" do
    # should have_and_belongs_to_many(:users)
    should have_many(:tickets).dependent(:destroy)
    should have_many(:ticket_statuses).dependent(:destroy)
    should have_many(:ticket_types).dependent(:destroy)    
    should belong_to(:default_status) # in future change to 'have_one'
    should belong_to(:user)
    should respond_to(:project_users)
  end
  
  it "should have validations" do
    should validate_presence_of(:name)    
  end
  
  context "that was created" do 
    before :each do
      @project = Factory(:project)
    end
    
    it "should have default statuses" do
      @project.ticket_statuses.count.should eql(3)
      @project.default_status.name.should eql('New')
    end
  
    it "should have ticket types" do
      @project.ticket_types.count.should eql(3)
    end    
  end
end
