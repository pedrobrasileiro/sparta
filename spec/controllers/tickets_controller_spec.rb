require 'spec_helper'

describe TicketsController do
  include Devise::TestHelpers

  ##
  # user is not authorized
  ##
  context 'unauthorized user' do
  end

  ##
  # user is authorized
  ##
  context 'authorized user' do
    sign_in_user

    before :each do
      @project = Factory(:project, :user_id => @user.id)
    end

    ##
    # index action
    ##
    describe '#index' do

      # Without any params
      context 'without params' do
        it 'should assign tickets of current project' do
          get :index, :project_id => @project.id
          assigns[:tickets].should eq @project.tickets
        end
      end

      # With get tags in get params
      context 'with params[:tags]' do

      end
    end
    
    ##
    # show action
    ##
    describe '#show' do
      it "should has new comment with ticket id and render show template" do
        ticket = Factory(:ticket, :project_id => @project.id)
        get :show, :project_id => @project.id, :id => ticket
        assigns[:comment].ticket.id.should == ticket.id
        response.should render_template 'tickets/show', :layout => false        
      end
    end    

    ##
    # new action
    ##
    describe '#new' do

    end

    ##
    # create action
    ##
    describe '#create' do

    end

    ##
    # edit action
    ##
    describe '#edit' do

    end

    ##
    # update action
    ##
    describe '#update' do

    end

    ##
    # destory action
    ##
    describe '#destroy' do

    end
  end
end
