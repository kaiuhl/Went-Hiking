class Comment < ActiveRecord::Base
	belongs_to :hike
	belongs_to :user
	validates_presence_of :body, :on => :create, :message => "can't be blank"
end
