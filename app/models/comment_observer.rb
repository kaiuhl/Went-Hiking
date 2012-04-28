class CommentObserver < ActiveRecord::Observer
  include Rails.application.routes.url_helpers

  def after_create(comment)
    trip = comment.trip
    author = comment.user
    previous_posters = trip.comments.map(&:user).uniq.reject{|u| u.id == author.id}

    # Send owner of hike an email and notification
    WebsiteMailer.comment_posted(comment).deliver if trip.user.notify_on_comment && (trip.user.id != author.id)
    trip.user.notifications.send!(comment, author, user_trip_path(trip.user, trip))

    # Send previous commenters in the thread a notification only
    previous_posts.each {|user| user.notifications.send!(comment, author, user_trip_path(trip.user, trip)) }
  end
end
