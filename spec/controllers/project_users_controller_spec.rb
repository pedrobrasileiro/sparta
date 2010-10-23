require 'spec_helper'

describe ProjectUsersController do
  include Devise::TestHelpers
    
  context 'unauthorized user' do
    before :each do
      @project = Factory(:project)
    end
    
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
    
    before :each do
      @project = Factory(:project, :user => @user)
    end
    
    describe '#index' do
      it 'user should have access to project users index' do
        get :index,
            :project_id => @project.id
        response.status.should eql 200
      end
    end
    
    describe '#create' do
      it "user should have access to add new user to project" do
        @user = Factory(:user, :email => 'user@example.com')
        post :create,
             :project_id => @project.id,
             :user       => @user
        
        @project.users.should include @user
      end
    end
    
    describe '#destroy' do
      it "user should have access to delete user from project" do
        user = Factory(:user)
        @project.users << user
        delete :destroy,
               :project_id => @project.id,
               :id       => user
               
        @project.users(true).should_not include user
      end
    end
  end  
end
