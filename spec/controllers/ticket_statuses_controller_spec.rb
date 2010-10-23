require 'spec_helper'

describe TicketStatusesController do
  include Devise::TestHelpers
    
  context 'unauthorized user' do
    before :each do
      @project = Factory(:project)
    end
    
    it 'user should have no access to all actions' do
      lambda { get :index, 
                   :project_id => @project }.should raise_exception(CanCan::AccessDenied)

      lambda { get :new, 
                   :project_id => @project }.should raise_exception(CanCan::AccessDenied)
      
      
      lambda { post :create, 
                    :project_id => @project }.should raise_exception(CanCan::AccessDenied)
                    
      lambda { get :edit, 
                   :project_id => @project,
                   :id => 1 }.should raise_exception(CanCan::AccessDenied)
                          
      lambda { put :update, 
                   :project_id => @project,
                   :id => 1 }.should raise_exception(CanCan::AccessDenied)

      lambda { delete :destroy, 
                      :project_id => @project,
                      :id => 1 }.should raise_exception(CanCan::AccessDenied)
                         
    end    
  end
  
  context 'authorized user' do
    sign_in_user
    
    before :each do
      @project = Factory(:project, :user => @user)
    end
    
    describe '#create' do
      it "user should have access to add new ticket status" do
        post :create,
             :project_id    => @project.id,
             :ticket_status => Factory.attributes_for(:ticket_status)
        
        response.should redirect_to :index
      end
    end
    
    describe '#update' do
      it "user should have access to update ticket status" do
        ticket_status = Factory(:ticket_status)
        @project.ticket_statuses << ticket_status
        put :update,
            :project_id    => @project.id,
            :id            => ticket_status,
            :ticket_status => ticket_status
               
        response.should redirect_to :index
      end
    end
  end  
end
