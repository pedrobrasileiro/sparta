require 'spec_helper'
require 'cancan/matchers'

# Examples for CommonPagesController
describe CommonPagesController do
  include Devise::TestHelpers

  # Samples to test show action
  describe '#show' do
    it 'should render template from id params' do
      get :show, :id => 'home'
      response.should render_template 'common_pages/home'
    end

    describe 'ability' do
      it 'unauthorized user should have access' do
        get :show, :id => 'home'
        response.status.should == 200
      end

      it 'authorized user should have access' do
        sign_in Factory(:user)

        get :show, :id => 'home'
        response.status.should == 200
      end
    end
  end
end
