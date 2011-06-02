class Gpx < ActiveRecord::Base
	belongs_to 					:hike
	after_create 				:extract_geometry
	
	has_attached_file 	:data, :styles => {}
	
	validates_attachment_size :image,
    :less_than      => 10.megabytes,
    :greater_than   => 1.kilobyte,
    :message        => "Maximum file size is 10 megabytes."

  validates_attachment_presence :data

  validates_attachment_content_type :data, :content_type => [
    'text/xml',
		'application/gpx+xml'
  ], :message => "You didn't upload a .GPX file"
	
	private
	
	def extract_geometry
		doc = Nokogiri::XML(open("#{Rails.root}#{data.url(:original, false)}"))
		trackpoints = doc.xpath('//xmlns:trkpt')
		points = []
		trackpoints.each do |trackpoint|
		  points << [	
				trackpoint.xpath('@lat').to_s.to_f, 
				trackpoint.xpath('@lon').to_s.to_f, 
				trackpoint.xpath('xmlns:ele').text.to_f,
				trackpoint.xpath('xmlns:time').text.to_datetime 
			]
		end
		
		# <TODO>
		# Throw this in database, make sure it includes datetime and elevation
		points
		# </TODO>
	end
end
