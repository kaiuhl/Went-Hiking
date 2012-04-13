xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@user.name}'s Trip Log"
    xml.description "a log of #{@user.name}'s trips and backpacking trips on http://wenthiking.com"
    xml.link root_url
  
		@trips.each do |trip|
			xml.item do
				xml.title 				"#{trip.name} (hiked #{trip.hiked_at.strftime('%D')})"
				xml.description		"<p>#{trip.mileage % 1 == 0 ? trip.mileage.to_i : trip.mileage} miles of hiking &bull;
				#{trip.elevation}' elevation gain</p>  #{markdown(trip.report)}"
				xml.link 					user_trip_url(@user, trip)
			end
		end
  end
end