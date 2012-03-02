class WebsiteMailer < ActionMailer::Base
  @@options = {
    :title  => "Went Hiking", 
    :url    => "http://wenthiking.com",
		:from   => "Went Hiking <kyle@wenthiking.com>"
  }
  
  layout 'email'
  def welcome_email(password, user, current_user)
    recipients    user.email
    from          @@options[:from]
    subject       "Registration Info"
    body          :user => user, :options => @@options, :password => password
    content_type  "text/html"
  end
  
  def reset_password(user)
    recipients    user.email
    bcc           "kaiuhl@gmail.com"
    from          @@options[:from]
    subject       "Your password has been reset"
    body          :user => user, :options => @@options
    content_type  "text/html"
  end

	def feedback
		recipients    "kaiuhl@gmail.com"
    from          @@options[:from]
    subject       "Registration Info"
    body          :user => user, :options => @@options, :password => password
    content_type  "text/html"
	end
	
	def comment_posted(comment)
    recipients    comment.hike.user.email
    from          @@options[:from]
    subject       "Comment posted on #{comment.hike.name}"
    body          :comment => comment, :options => @@options
    content_type  "text/html"
	end
	
	def reply_posted(comment, user)
    recipients    user.email
    from          @@options[:from]
    subject       "Reply posted on #{comment.hike.name}"
    body          :comment => comment, :options => @@options, :user => user
    content_type  "text/html"
	end
	
	def admin_email(message)
		recipients 		User.where()
	end
end
