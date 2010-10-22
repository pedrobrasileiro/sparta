require 'spec_helper'

# Examples for CommonPagesController
describe CommonPagesController do
  include Devise::TestHelpers

  # Samples to test show action
  describe 'show action' do
    it 'should render template from id params' do
      get :show, :id => 'home'
      response.should render_template 'common_pages/home'
    end
  end
end
