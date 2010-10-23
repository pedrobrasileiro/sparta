require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers

  before :each do
    @ticket = Factory(:ticket)
  end

  context 'unauthorized user' do
    describe '#index' do
      it 'user should have not access to comments index' do
        lambda { get :index, 
                     :project_id => @ticket.project_id, 
                     :ticket_id  => @ticket.id  }.should raise_exception(CanCan::AccessDenied)
      end
    end
      
    describe '#create' do  
      it 'user should have not access to comments create' do
        lambda { post :create, 
                      :project_id => @ticket.project_id, 
                      :ticket_id  => @ticket.id  }.should raise_exception(CanCan::AccessDenied)
      end
    end
  end
  
  context 'authorized user' do
    sign_in_user
    
    describe '#index' do
      it 'user should have access to comments index' do
        get :index,
            :project_id => @ticket.project_id,
            :ticket_id  => @ticket.id
        response.status.should eql 200
      end
    end
    
    describe '#create' do
      it "user should have access to create new comment" do
        post :create,
             :project_id => @ticket.project_id,
             :ticket_id  => @ticket.id,
             :comment    => Factory.attributes_for(:comment)
             
        @user.comments.count.should eql 1
      end
    end
  end
end
