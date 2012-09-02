class Notification < ActiveRecord::Base
	belongs_to :content, :polymorphic => true
	belongs_to :creator, :polymorphic => true
	belongs_to :subject, :polymorphic => true

  default_scope -> { order("created_at DESC") }
  scope :unread, -> { where(read_at: nil) }

  def self.send!(content, creator, subject, url)
    create! do |notification|
      notification.content_type = content.class.to_s
      notification.content_id = content.id
      notification.creator_type = creator.class.to_s
      notification.creator_id = creator.id
      notification.subject_type = subject.class.to_s
      notification.subject_id = subject.id
      notification.uri = url
    end
  end
end
