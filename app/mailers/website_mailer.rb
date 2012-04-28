class WebsiteMailer < ActionMailer::Base
  default from: "Went Hiking <kyle@wenthiking.com>"
  @@options = {
    :title  => "Went Hiking",
    :url    => "http://wenthiking.com"
  }

  layout 'email'
  def welcome_email(password, user, current_user)
    @user = user
    @options = @@options
    @password = password
    mail to: user.email, subject: "Registration information"
  end

  def reset_password(user)
    @user = user
    @options = @@options
    mail to: user.email, subject: "Your password has been reset"
  end

	def comment_posted(comment)
    @comment = comment
    @options = @@options
    mail to: comment.trip.user.email, subject: "Comment posted on #{comment.trip.name}"
	end

	def reply_posted(comment, user)
    @comment = comment
    @user = user
    @options = @@options
    mail to: user.email, subject: "Reply posted on #{comment.trip.name}"
	end
end
