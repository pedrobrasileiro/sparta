require 'spec_helper'

describe TicketStatus do
  it "should have associations" do
    should have_many(:tickets)
    should belong_to(:project)
  end
end
