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
  
  it "should autoincrement number of new ticket" do
    Ticket.destroy_all
    3.times do 
      Factory(:ticket)
    end
    Ticket.all.last.number.should eql 3
    Ticket.all.first.number.should eql 1
  end    

  context "that was created" do     
    before :each do
      @ticket = Factory(:ticket)
    end    
  
    it "should have default status" do
      @ticket.status.name.should eql 'New'
    end
    
    it "should close if status closed" do
      @ticket.update_attributes :status => @ticket.project.ticket_statuses.closing.first
      @ticket.closed.should be_true
      @ticket.update_attributes :status => @ticket.project.ticket_statuses.opening.first
      @ticket.closed.should be_false
    end
  end
end
