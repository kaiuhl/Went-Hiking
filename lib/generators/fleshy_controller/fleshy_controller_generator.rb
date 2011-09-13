class FleshyControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

	def generate_controller
		template "controller.erb", "app/controllers/#{name.underscore.pluralize}_controller.rb"
		route "resources :#{name.underscore.pluralize}"
		empty_directory "app/views/#{name.underscore.pluralize}"
	end
end
