require 'test_helper'

class MainControllerTest < ActionController::TestCase

  context 'signed in' do
    setup do
      @user = users(:one)
      sign_in @user
    end

    should 'redirect to posts' do
      get :index
      assert_redirected_to user_posts_path(@user)
    end
  end
  
  context 'signed out' do
    should 'redirect to posts' do
      get :index
      assert_response :success
      assert_template :index
    end
  end
end
