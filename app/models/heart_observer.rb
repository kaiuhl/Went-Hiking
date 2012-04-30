class HeartObserver < ActiveRecord::Observer
  include Rails.application.routes.url_helpers

  def after_create(heart)
    trip = heart.trip
    trip_author = trip.user

    # send a notification to the hike's author of the heart
    trip_author.notifications.send!(heart, heart.user, trip, user_trip_path(trip_author, trip))
  end

  def before_destroy(heart)
    Notification.find_by_content_id_and_creator_id_and_subject_id(heart, heart.user, heart.trip).destroy
  end
end
