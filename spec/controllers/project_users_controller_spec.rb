require 'spec_helper'

describe ProjectUsersController do
  include Devise::TestHelpers
  
  before :each do
    @project = Factory(:project)
  end
  
  context 'unauthorized user' do
    describe '#index' do
      it 'user should have no access to project users index' do
        lambda { get :index, 
                     :project_id => @project }.should raise_exception(CanCan::AccessDenied)
      end
    end
      
    describe '#create' do  
      it 'user should have no access to project users create' do
        lambda { post :create, 
                      :project_id => @project }.should raise_exception(CanCan::AccessDenied)
      end
    end
    
    describe '#destroy' do  
      it 'user should have no access to project users destroy' do
        @project.users << Factory(:user)
        lambda { delete :destroy, 
                        :project_id => @project.id,
                        :id => @project.users.first }.should raise_exception(CanCan::AccessDenied)
      end
    end
  end
  
  context 'authorized user' do
    sign_in_user
    
    # describe '#index' do
    #   it 'user should have access to project users index' do
    #     get :index,
    #         :project_id => @project.id
    #     assigns[:user].project_id.should eql 1  
    #     response.status.should eql 200
    #   end
    # end
    # 
    # describe '#create' do
    #   it "user should have access to create new comment" do
    #     post :create,
    #          :project_id => @ticket.project_id,
    #          :ticket_id  => @ticket.id,
    #          :comment    => Factory.attributes_for(:comment)
    #          
    #     @user.comments.count.should eql 1
    #   end
    # end
  end  
end
