xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@user.name}'s Trip Log"
    xml.description "a log of #{@user.name}'s hikes and backpacking trips on http://wenthiking.com"
    xml.link root_url
  
		@hikes.each do |hike|
			xml.item do
				xml.title 				"#{hike.name} (hiked #{hike.hiked_at.strftime('%D')})"
				xml.description		"<p>#{hike.mileage % 1 == 0 ? hike.mileage.to_i : hike.mileage} miles of hiking &bull;
				#{hike.elevation}' elevation gain</p>  #{markdown(hike.report)}"
				xml.link 					user_hike_url(@user, hike)
			end
		end
  end
end