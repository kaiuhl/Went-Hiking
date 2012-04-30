module ApplicationHelper
	# Process text with Markdown.                                                                 
  def markdown(text)
    BlueCloth::new(h(text.html_safe)).to_html.html_safe rescue ""
  end
	def static_map(lat, lng, size = "265x100", zoom = 10)
		url =  "http://maps.google.com/maps/api/staticmap?sensor=false"
		url << "&size=#{size}"
		url << "&zoom=#{zoom}"
		url << "&maptype=terrain"
		url << "&markers=icon:http%3A%2F%2Fwenthiking.com%2Fimages%2Fmarkersmall.png"
		url << "|#{lat},#{lng}"
	end
	def page_title(t = nil)
		if t
			content_for(:title) { t }
		else
			content_for?(:title) ? content_for(:title) : "Untitled"
		end
	end
	def yield_for(content_sym, default)
    output = content_for(content_sym)
    output = default if output.blank?
    output
  end
	def comments_and_likes(trip)
		buffer = image_tag("comment.png") << " "
		buffer << link_to("#{trip.comments.size} comments", "#{user_trip_path(trip.user,trip)}#comments")
		buffer
	end
end
