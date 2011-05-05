# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def random_phrase
		phrases = [
			"We went hiking and kept track because we're nerds, and we like it.",
			"Keeping track of where and how far you went in the wilderness for no specific purpose.",
			"We may like to escape to the woods, but we're not animals.",
			"A tent is the only place where freeze-dried, subpar chicken is licked off the spoon.",
			"Remember that time we hiked to that lake and swam all day? Now we do."
		]
		phrases[rand(phrases.length).to_i]
	end
	
	def static_map(lat, lng, size = "265x100", zoom = 10)
		url =  "http://maps.google.com/maps/api/staticmap?sensor=false"
		url << "&size=#{size}"
		url << "&zoom=#{zoom}"
		url << "&maptype=terrain"
		url << "&markers=icon:http%3A%2F%2Fwenthiking.com%2Fimages%2Fmarkersmall.png"
		url << "|#{lat},#{lng}"
	end
end
