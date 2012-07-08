require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  context 'signed in' do
    setup do
      @post = posts(:one)
      @user = users(:one)
      sign_in @user
    end

    should "get index" do
      get :index
      assert_response :success
      assert_equal [@post], assigns(:posts)
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create post" do
      assert_difference('Post.count') do
        post :create, post: { title: 'hello', body: 'body' }
      end

      assert_redirected_to post_path(assigns(:post))
    end

    should "show post" do
      get :show, id: @post
      assert_response :success
    end
    
    should "get edit" do
      get :edit, id: @post
      assert_response :success
    end

    should "update post" do
      put :update, id: @post, post: { title: 'hello', body: 'body' }
      assert_redirected_to post_path(assigns(:post))
    end

    should "destroy post" do
      assert_difference('Post.count', -1) do
        delete :destroy, id: @post
      end

      assert_redirected_to posts_path
    end

    context 'viewing anothers posts' do
      setup { post_two = posts(:two) }
    
      should "not show others post" do
        assert_raise ActiveRecord::RecordNotFound do
          get :show, id: 2
        end
      end

      should "not list others posts" do
        get :index, :user_id => 2
        assert_equal [@post], assigns(:posts)
        assert_response :success
      end

      should "not edit anothers post" do
        assert_raise ActiveRecord::RecordNotFound do
          get :edit, :id => 2
        end
      end

      should "not update anothers post" do
        assert_raise ActiveRecord::RecordNotFound do
          put :update, :id => 2
        end
      end
      
      should "not delete anothers post" do
        assert_raise ActiveRecord::RecordNotFound do
          delete :destroy, :id => 2
        end
      end

      should "not create a post for another user" do
        assert_raise ActiveModel::MassAssignmentSecurity::Error do
          post :create, post: { title: 'hello', body: 'body', user_id: 2 }
        end
      end
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
        post :create, post: { title: 'hello', body: 'body' } 
      end
      assert_redirected_to new_user_session_path
    end
    
    should "should not update post" do
      put :update, id: @post, post: { title: 'hello', body: 'body' }
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
