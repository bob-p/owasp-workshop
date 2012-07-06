require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  context 'signed in' do
    setup do
      @post = posts(:one)
      @user = users(:one)
      sign_in @user
    end

    should "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:posts)
    end

    should "should get new" do
      get :new
      assert_response :success
    end

    should "should create post" do
      assert_difference('Post.count') do
        post :create, post: { title: 'hello', body: 'body', user_id: @user.id }
      end

      assert_redirected_to post_path(assigns(:post))
    end

    should "should show post" do
      get :show, id: @post
      assert_response :success
    end

    should "should get edit" do
      get :edit, id: @post
      assert_response :success
    end

    should "should update post" do
      put :update, id: @post, post: { title: 'hello', body: 'body', user_id: @user.id }
      assert_redirected_to post_path(assigns(:post))
    end

    should "should destroy post" do
      assert_difference('Post.count', -1) do
        delete :destroy, id: @post
      end

      assert_redirected_to posts_path
    end
  end

  context 'signed out' do
    setup do
      @post = posts(:one)
    end

    should 'not get index' do
      get :index
      assert_redirected_to new_user_session_path
    end
    
    should "not get new" do
      get :new
      assert_redirected_to new_user_session_path
    end
    
    should "not get show" do
      get :show, id: @post
      assert_redirected_to new_user_session_path
    end
    
    should "not get edit" do
      get :edit, id: @post
      assert_redirected_to new_user_session_path
    end
    
    should "not post create" do
      assert_no_difference 'Post.count' do
        post :create, post: { title: 'hello', body: 'body', user_id: 1 } 
      end
      assert_redirected_to new_user_session_path
    end
    
    should "should not update post" do
      put :update, id: @post, post: { title: 'hello', body: 'body', user_id: 1 }
      assert_redirected_to new_user_session_path
    end

    should "should destroy post" do
      assert_no_difference('Post.count') do
        delete :destroy, id: @post
      end

      assert_redirected_to new_user_session_path
    end
  end
end
