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

    ##
    # index action
    ##
    describe '#index' do

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

