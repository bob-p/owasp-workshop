require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'a post' do
    should validate_presence_of :title
    should validate_presence_of :body
    should validate_presence_of :user

    should belong_to :user
  end
end
