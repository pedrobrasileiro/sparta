require 'spec_helper'

describe ProjectsController do
  include Devise::TestHelpers

  context 'unauthorized user' do
    describe '#index' do
      it 'user should have not access to projects index' do
        lambda { get :index }.should raise_exception(CanCan::AccessDenied)
      end
    end
  end

  context 'authorized user' do
    sign_in_user

    describe '#index' do
      it 'user should have access to projects index' do
        get :index
        response.status.should eql 200
      end

      it 'should assign user projects' do
        @user.projects << [Factory(:project), Factory(:project)]
        get :index
        assigns[:projects].should eq controller.current_user.projects
      end
    end

    describe '#new' do
      it 'should assign new project' do
        get :new
        assigns[:project].should_not be_nil
      end

      it 'should assign new record of project' do
        get :new
        assigns[:project].new_record?.should be_true
      end
    end

    describe '#create' do
      it 'should create project' do
        post :create, :project => { :name => 'Unique name' }
        Project.find_by_name('Unique name').should_not be_nil
      end
    end
  end
end
