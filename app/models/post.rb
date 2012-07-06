class Post < ActiveRecord::Base

  ### Associations ###
  belongs_to :user

  ### Validations ###
  validates :title, :presence => true
  validates :body, :presence => true
  validates :user, :presence => true
end
