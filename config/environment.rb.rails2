RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'authlogic'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gemcutter.org'
  config.gem 'formtastic', :source => 'http://gemcutter.org'
  config.gem 'flapcore'
  config.gem 'bluecloth'
  config.gem 'mini_magick'
	config.gem 'after_commit'
	config.gem 'exifr'
	config.gem 'geokit'
	config.gem 'nofxx-georuby', :lib => "geo_ruby"
	config.gem 'libxml-ruby', :lib => 'libxml'
	config.gem 'noaa'
	config.gem 'whenever'
	config.gem 'gpx'
	config.gem 'rails-upgrade'

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Pacific Time (US & Canada)'
end