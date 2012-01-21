class Notification < ActiveRecord::Base
	belongs_to :content, :polymorphic => true
	belongs_to :creator, :polymorphic => true
end
