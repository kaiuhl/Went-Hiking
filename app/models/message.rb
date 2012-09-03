class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :to, :from
  belongs_to :user, dependent: :destroy 
end
