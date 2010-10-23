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
