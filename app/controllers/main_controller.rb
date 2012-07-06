class MainController < ApplicationController
  def index
    redirect_to user_posts_path(current_user) if current_user
  end
end
