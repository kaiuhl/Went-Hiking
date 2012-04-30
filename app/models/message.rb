class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :read, :recipient_id, :author_id
  belongs_to :user, dependent: :destroy 
end
