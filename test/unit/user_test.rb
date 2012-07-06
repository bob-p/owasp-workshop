require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'a user' do
    should have_many :posts
  end
end
