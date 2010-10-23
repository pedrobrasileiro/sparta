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
        response.status.should == 200
      end

      it 'should assign user projects' do
        get :index
        assigns[:projects].should == controller.current_user.projects
      end
    end
  end
end
