class FleshyViewsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

	def generate_views
		template "index.html.erb", "app/views/#{name.underscore.pluralize}/index.html.erb"
		template "show.html.erb", "app/views/#{name.underscore.pluralize}/show.html.erb"
		template "edit.html.erb", "app/views/#{name.underscore.pluralize}/edit.html.erb"
		template "new.html.erb", "app/views/#{name.underscore.pluralize}/new.html.erb"
		template "_form.html.erb", "app/views/#{name.underscore.pluralize}/_form.html.erb"
	end
end
