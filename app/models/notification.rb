class Notification < ActiveRecord::Base
	belongs_to :content, :polymorphic => true
	belongs_to :creator, :polymorphic => true

  def self.send!(content, creator, url)
    create! do |notification|
      notification.content_type = content.class.to_s
      notification.content_id = content.id
      notification.creator_type = creator.class.to_s
      notification.creator_id = creator.id
      notification.uri = url
    end
  end
end
