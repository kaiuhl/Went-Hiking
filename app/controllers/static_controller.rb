class StaticController < ApplicationController
  def index
    unless params[:path].blank?
      if template_exists?(path = "static/#{params[:path]}") && params[:path].last.include?(".js")
				render :file => path    
      elsif template_exists?(path)
        	render :file => path, :layout => "layouts/#{path}" rescue render :file => path, :layout => "application"
			else
        raise ::ActionController::RoutingError, "Recognition failed for #{request.path.inspect}"
      end
    else
      render :file => "static/home", :layout => "application"
    end
  end
  
  private
  
  def template_exists?(path)
    self.view_paths.find_template(path, response.template.template_format) rescue ActionView::MissingTemplate
  end
end