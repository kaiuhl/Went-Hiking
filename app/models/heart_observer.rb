class HeartObserver < ActiveRecord::Observer
  include Rails.application.routes.url_helpers

  def after_create(heart)
    trip = heart.trip
    trip_author = trip.user

    # send a notification to the hike's author of the heart
    trip_author.notifications.send!(heart, heart.user, user_trip_path(trip_author, trip))
  end
end
