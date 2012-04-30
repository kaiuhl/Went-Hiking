class CommentsController < ApplicationController
	before_filter :authorize

	def index
		@comments = Comment.where(:user_id => current_user.id)
	end

  def create
		@comment = Comment.new(params[:comment])
		if @comment.save
			redirect_to user_trip_path(@comment.trip.user, @comment.trip) + "#comments"
		end
  end

	def edit
		@comment = Comment.find(params[:id])
		@trip = @comment.trip
		redirect_to :back unless current_user.id == @comment.user_id
	end

	def update
		@comment = Comment.find(params[:id])
		@trip = @comment.trip
		redirect_to :back unless current_user.id == @comment.user_id
		if @comment.update_attributes(params[:comment])
			redirect_to "#{user_trip_path(@trip.user, @trip)}#comment_#{@comment.id}"
		else
			render :action => "edit"
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:notice] = "Deleted comment."
		redirect_to :back
	end
end
